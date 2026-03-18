#include "platform.h"

#include "util.h"
#include "net.h"

struct net_protocol {
    struct net_protocol *next;
    uint16_t type;
    struct queue_head queue; /* input queue */
    void (*handler)(const uint8_t *data, size_t len, struct net_device *dev);
};

struct net_protocol_queue_entry {
    struct net_device *dev;
    size_t len;
    uint8_t data[];
};

struct net_timer {
    struct net_timer *next;
    struct timeval interval;
    struct timeval last;
    void (*handler)(void);
};

struct net_event {
    struct net_event *next;
    void (*handler)(void *arg);
    void *arg;
};

/* NOTE: if you want to add/delete the entries after net_run(), you need to protect these lists with a mutex. */
static struct net_device *devices;
static struct net_protocol *protocols;
static struct net_timer *timers;
static struct net_event *events;

struct net_device *
net_device_alloc(void)
{
    struct net_device *dev;

    dev = memory_alloc(sizeof(*dev));
    if (!dev) {
        return NULL;
    }
    return dev;
}

/* NOTE: must not be call after net_run() */
int
net_device_register(struct net_device *dev)
{
    static unsigned int index = 0;

    dev->index = index++;
    snprintf(dev->name, sizeof(dev->name), "net%d", dev->index);
    dev->next = devices;
    devices = dev;
    return 0;
}

int
net_device_open(struct net_device *dev)
{
    if (NET_DEVICE_IS_UP(dev)) {
        return -1;
    }
    if (dev->ops->open) {
        if (dev->ops->open(dev) == -1) {
            return -1;
        }
    }
    dev->flags |= NET_DEVICE_FLAG_UP;
    return 0;
}

int
net_device_close(struct net_device *dev)
{
    if (!NET_DEVICE_IS_UP(dev)) {
        return -1;
    }
    if (dev->ops->close) {
        if (dev->ops->close(dev) == -1) {
            return -1;
        }
    }
    dev->flags &= ~NET_DEVICE_FLAG_UP;
    return 0;
}

struct net_device *
net_device_by_index(unsigned int index)
{
    struct net_device *entry;

    for (entry = devices; entry; entry = entry->next) {
        if (entry->index == index) {
            break;
        }
    }
    return entry;
}

struct net_device *
net_device_by_name(const char *name)
{
    struct net_device *entry;

    for (entry = devices; entry; entry = entry->next) {
        if (strcmp(entry->name, name) == 0) {
            break;
        }
    }
    return entry;
}

/* NOTE: must not be call after net_run() */
int
net_device_add_iface(struct net_device *dev, struct net_iface *iface)
{
    struct net_iface *entry;

    for (entry = dev->ifaces; entry; entry = entry->next) {
        if (entry->family == iface->family) {
            return -1;
        }
    }
    iface->next = dev->ifaces;
    iface->dev = dev;
    dev->ifaces = iface;
    return 0;
}

struct net_iface *
net_device_get_iface(struct net_device *dev, int family)
{
    struct net_iface *entry;

    for (entry = dev->ifaces; entry; entry = entry->next) {
        if (entry->family == family) {
            break;
        }
    }
    return entry;
}

int
net_device_output(struct net_device *dev, uint16_t type, const uint8_t *data, size_t len, const void *dst)
{
    if (!NET_DEVICE_IS_UP(dev)) {
        return -1;
    }
    if (len > dev->mtu) {
        return -1;
    }
    if (dev->ops->transmit(dev, type, data, len, dst) == -1) {
        return -1;
    }
    return 0;
}

/* NOTE: must not be call after net_run() */
int
net_protocol_register(uint16_t type, void (*handler)(const uint8_t *data, size_t len, struct net_device *dev))
{
    struct net_protocol *proto;

    for (proto = protocols; proto; proto = proto->next) {
        if (type == proto->type) {
            return -1;
        }
    }
    proto = memory_alloc(sizeof(*proto));
    if (!proto) {
        return -1;
    }
    proto->type = type;
    proto->handler = handler;
    proto->next = protocols;
    protocols = proto;
    return 0;
}

/* NOTE: must not be call after net_run() */
int
net_timer_register(struct timeval interval, void (*handler)(void))
{
    struct net_timer *timer;

    timer = memory_alloc(sizeof(*timer));
    if (!timer) {
        return -1;
    }
    timer->interval = interval;
    gettimeofday(&timer->last, NULL);
    timer->handler = handler;
    timer->next = timers;
    timers = timer;
    return 0;
}

int
net_timer_handler(void)
{
    struct net_timer *timer;
    struct timeval now, diff;

    for (timer = timers; timer; timer = timer->next) {
        gettimeofday(&now, NULL);
        timersub(&now, &timer->last, &diff);
        if (timercmp(&timer->interval, &diff, <) != 0) {
            timer->handler();
            timer->last = now;
        }
    }
    return 0;
}

int
net_input_handler(uint16_t type, const uint8_t *data, size_t len, struct net_device *dev)
{
    struct net_protocol *proto;
    struct net_protocol_queue_entry *entry;

    for (proto = protocols; proto; proto = proto->next) {
        if (proto->type == type) {
            entry = memory_alloc(sizeof(*entry) + len);
            if (!entry) {
                return -1;
            }
            entry->dev = dev;
            entry->len = len;
            memcpy(entry->data, data, len);
            if (!queue_push(&proto->queue, entry)) {
                memory_free(entry);
                return -1;
            }
            intr_raise_irq(INTR_IRQ_SOFTIRQ);
            return 0;
        }
    }
    return 0;
}

int
net_softirq_handler(void)
{
    struct net_protocol *proto;
    struct net_protocol_queue_entry *entry;

    for (proto = protocols; proto; proto = proto->next) {
        while (1) {
            entry = queue_pop(&proto->queue);
            if (!entry) {
                break;
            }
            proto->handler(entry->data, entry->len, entry->dev);
            memory_free(entry);
        }
    }
    return 0;
}

/* NOTE: must not be call after net_run() */
int
net_event_subscribe(void (*handler)(void *arg), void *arg)
{
    struct net_event *event;

    event = memory_alloc(sizeof(*event));
    if (!event) {
        return -1;
    }
    event->handler = handler;
    event->arg = arg;
    event->next = events;
    events = event;
    return 0;
}

int
net_event_handler(void)
{
    struct net_event *event;

    for (event = events; event; event = event->next) {
        event->handler(event->arg);
    }
    return 0;
}

void
net_raise_event()
{
    intr_raise_irq(INTR_IRQ_EVENT);
}

int
net_run(void)
{
    struct net_device *dev;

    if (intr_run() == -1) {
        return -1;
    }
    for (dev = devices; dev; dev = dev->next) {
        net_device_open(dev);
    }
    return 0;
}

void
net_shutdown(void)
{
    struct net_device *dev;

    for (dev = devices; dev; dev = dev->next) {
        net_device_close(dev);
    }
    intr_shutdown();
}

#include "ip.h"
#include "arp.h"
#include "icmp.h"
#include "udp.h"
#include "tcp.h"

int
net_init(void)
{
    if (intr_init() == -1) {
        return -1;
    }
    if (ip_init() == -1) {
        return -1;
    }
    if (arp_init() == -1) {
        return -1;
    }
    if (icmp_init() == -1) {
        return -1;
    }
    if (udp_init() == -1) {
        return -1;
    }
    if (tcp_init() == -1) {
        return -1;
    }
    return 0;
}

void
netinit(void)
{
    if (net_init() == -1) {
        panic("net_init() failure");
    }
}

void
netrun(void)
{
    if (net_run() == -1) {
        panic("net_run() failure");
    }
}
