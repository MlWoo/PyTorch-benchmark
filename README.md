# PyTorch-benchmark  
Benchmarking of CNN part of a some project on different mainstreaming CPU platform with [PyTorch](https://github.com/pytorch/pytorch). Besides the [official PyTorch](https://github.com/pytorch/pytorch), we also provide an [Intel version](https://github.com/intel/pytorch/tree/icc) to maximize the performance on CPU platforms, in particular Intel® Xeon processors (HSW, BDW, Xeon Phi).  

Tested CPU：  

|Type|CPU Model|Sockets|Cores/Socket|Frequency|
|---|---|---|---|---|
|i7 |Intel(R) Core(TM) i7-5960X|1|8|3.00GHz|
|BDW|Intel(R) Xeon(R) CPU E5-2699 v4   |2|22|2.20GHz|
|KNL|Intel(R) Xeon Phi(TM) CPU 7250F   |1|68|1.40GHz|
|SKX|Intel(R) Xeon(R) Platinum 8180 CPU|2|28|2.50GHz|

## Installation  
Refer to [Intel version](https://github.com/intel/pytorch/tree/icc). It is important to warn you that the branch is __icc__.

## Benchmarking data  
Note: Part of optimization from Intel has been merged into offical version. The reference data is outdated.
Unit:(ms)

|PyTorch version|compiler |AVX512 support| CPU platform | result | speedUp |
|:----------:|:----------:|:----------:|:----------:|:----------:|:----------:|
|Official| GNU |  No | BDW | 1450| (reference)|
|Intel| GNU |  No | BDW | 220| 6.59X |
|Intel| Intel |  No | BDW | 172| 8.43X |
|Intel| Intel |  YES | KNL | 262| --|
|Intel| Intel |  YES | SKX | 111| --|
|Intel| GNU| No |i7|460|--|
