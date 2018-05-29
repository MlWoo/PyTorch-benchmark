#!/bin/bash
REPO_DIR=/home/dev/wumenglin/repo/marpytorch
BENCH_DIR=/home/dev/wumenglin/benchmark/pytorch-rnn-benchmark
INSTALL_DIR=/home/dev/workspace/pythonEnv/intelPytorch/lib/python3.6/site-packages/

cd ${REPO_DIR}
#git pull


commit_id_cur=$(git rev-parse HEAD)
commit_id_term='333e8c9b227057635d365af96430cc6f4a1bab86'
commit_id_test='dbac3d21f67ab3ef8090471e16af15df0a8ae808'
test_flag=true

#echo $commit_id_cur
#echo $commit_id_test
#if [[ $commit_id_cur == $commit_id_test ]]; then
#  test_flag=false
#fi
#
#echo $test_flag

while ${test_flag}
do

  cd ${INSTALL_DIR}
  rm -rf torch*
  cd ${REPO_DIR}
  ./install.sh
  cd test
  python import_torch.py &> python.log
  rst=`sed '/^$/!h;$!d;g' python.log`
  if [ -n "$rst" ]
  then
    echo "========================================== rebuild thouroughly"
    cd ${REPO_DIR}
    python setup.py clean
    ./install.sh
  else
    echo "------------------------------------------ rebuild slightly"
  fi


  cd ${BENCH_DIR}
  #pwd
  bench_log=$(./run.sh)
  IFS=$'\n'
  for line in $bench_log
  do
    line_last=$line
  done


  IFS=$'='
  for elem in $line_last
  do
    data=$elem
  done

  echo $commit_id_cur $data >> benchmark_log.data

  cd ${REPO_DIR}
  dummy_log=$(git reset --hard HEAD^)
  commit_id_cur=$(git rev-parse HEAD)
  #echo $commit_id_cur

  if [[ $commit_id_cur == $commit_id_term ]]; then
    test_flag=false
  fi
done



