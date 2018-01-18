from __future__ import print_function
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.autograd  import Variable
import torch.optim as optim
import time
import random
class conv3d_net(nn.Module):
    def __init__(self):
        super(conv3d_net, self).__init__()
        self.conv3d_1 = nn.Conv3d(1, 64, kernel_size=3)
        self.conv3d_2 = nn.Conv3d(64, 64, kernel_size=3)
        self.conv3d_3 = nn.Conv3d(64, 128, kernel_size=3)
        self.conv3d_4 = nn.Conv3d(128, 128, kernel_size=3)
        self.fc1 = nn.Linear(6400, 512)
        self.fc2 = nn.Linear(512, 512)

    def forward(self, x):
        x = self.conv3d_2(self.conv3d_1(x))
        x = F.max_pool3d(x, 2)
        x = self.conv3d_4(self.conv3d_3(x))
        x = F.max_pool3d(x, 2)
        x = x.view(-1, 6400)
        x = self.fc2(self.fc1(x))
        return F.log_softmax(x, 0)


model = conv3d_net()
optimizer = optim.SGD(model.parameters(), lr = 0.1, momentum = 0.9)

warmup = 5
cycle = 10
start_t = 0
end_t = 0
def train():
    #warmup
    data = torch.randn(4, 1, 35, 35, 20)
    target = torch.LongTensor(4).zero_()
    for j in range(4):
        hot_idx = random.randint(0, 511)
        target[j]= hot_idx
    data, target = Variable(data), Variable(target)
    for i in range(warmup+cycle):
        if (i == warmup):
            start_t = time.time()
        #optimizer.zero_grad()
        output = model(data)
        loss = F.nll_loss(output, target)
        loss.backward()
        #optimizer.step()
    end_t = time.time()
    duration = (end_t - start_t)*1000.0/cycle
    print("avg time", duration, "millisecond")

train()

