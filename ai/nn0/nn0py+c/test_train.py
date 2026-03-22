import sys
f = open('/tmp/test_output.txt', 'w')

from nn0 import Tensor
from nn import SGD, CrossEntropyLoss, Softmax
from examples.mnist import SimpleMLP, load_mnist, create_batches

f.write('Modules loaded\n')
f.flush()

model = SimpleMLP()
criterion = CrossEntropyLoss()
optimizer = SGD(model.parameters(), lr=0.01)

f.write('Loading data...\n')
f.flush()

train_x, train_y, _, _ = load_mnist()
train_x, train_y = train_x[:100], train_y[:100]
batches_x, batches_y = create_batches(train_x, train_y, 10, shuffle=False)

f.write(f'Created {len(batches_x)} batches\n')
f.flush()

batch_x = batches_x[0]
batch_y = batches_y[0]

f.write('Zero grad...\n')
f.flush()
optimizer.zero_grad()

f.write('Forward...\n')
f.flush()
out = model(batch_x)
f.write(f'Output shape: {out.shape}\n')
f.flush()

f.write('Manual loss calc...\n')
f.flush()
softmax = Softmax()
prob = softmax(out)
f.write(f'Prob shape: {prob.shape}\n')
f.flush()

f.write('Done!\n')
f.close()
