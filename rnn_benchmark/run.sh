#!/bin/sh

lscpu
which python
export KMP_AFFINITY=compact,1,0,granularity=fine
python LSTM.py daily

