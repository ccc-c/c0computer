#ifndef _XV6_TYPES_H
#define _XV6_TYPES_H

typedef unsigned int   uint;
typedef unsigned short ushort;
typedef unsigned char  uchar;

typedef unsigned char uint8;
typedef unsigned short uint16;
typedef unsigned int  uint32;
typedef unsigned long uint64;

#ifndef _UINT8_T
typedef unsigned char uint8_t;
#endif
#ifndef _UINT16_T
typedef unsigned short uint16_t;
#endif
#ifndef _UINT32_T
typedef unsigned int uint32_t;
#endif
#ifndef _UINT64_T
typedef unsigned long uint64_t;
#endif

#ifndef _SIZE_T
typedef unsigned long size_t;
#endif
#ifndef _SSIZE_T
typedef long ssize_t;
#endif

typedef uint64 pde_t;

#endif
