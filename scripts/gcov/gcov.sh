#!/bin/bash

#配置项目目录信息
export BENCH_DIR="/home/zym/桌面"
export SUBJECT="$BENCH_DIR/gcov-project/binutils-2.39/binutils"

#需要输入两个参数：使用的fuzzer+被测试的工具名称，例如：./gcov.sh afl readelf
if [ $# -lt 2 ]; then
  echo "parameter not allow , example:'./gcov.sh afl readelf'"
  exit 1
fi
export FUZZER=$1
export TARGET=$2

#删除并重建存放gcov数据的文件夹
rm -rf gcov_data/$FUZZER/$TARGET
mkdir gcov_data/$FUZZER/$TARGET
cd fuzz_data/$FUZZER/$TARGET

#执行python脚本文件，按照分钟对fuzz数据进行分组，共60组，每组存放这一分钟内变异的测试用例
./$FUZZER.py

#利用gcov复现每分钟fuzz数据的覆盖率信息
cd ../../../
for idx in {1..60};do
  if [ $TARGET == "readelf" ]; then
    ./$TARGET -a fuzz_data/$FUZZER/$TARGET/results/$idx/*
  elif [ $TARGET == "objdump" ]; then
  ./$TARGET -SD fuzz_data/$FUZZER/$TARGET/results/$idx/*
  elif [ $TARGET == "cxxfilt" ]; then
  ./$TARGET fuzz_data/$FUZZER/$TARGET/results/$idx/*
  elif [ $TARGET == "nm" ]; then
  ./$TARGET -C fuzz_data/$FUZZER/$TARGET/results/$idx/*
  elif [ $TARGET == "size" ]; then
  ./$TARGET fuzz_data/$FUZZER/$TARGET/results/$idx/*
  fi
  gcov $TARGET.c
  mkdir gcov_data/$FUZZER/$TARGET/$idx
  cp $TARGET.gcda gcov_data/$FUZZER/$TARGET/$idx
  cp $TARGET.gcno gcov_data/$FUZZER/$TARGET/$idx
  cp $TARGET.c.gcov gcov_data/$FUZZER/$TARGET/$idx
done
rm -f $TARGET.gcda $TARGET.c.gcov

#创建一个文本文件data.txt，存放每分钟gcov覆盖率信息
cd gcov_data/$FUZZER/$TARGET
touch data.txt

#利用lcov，生成coverage.info，并提取其中的.c文件覆盖率信息，生成result.info
for idx in {1..60};do
  cd $idx
  lcov -c -d . -o coverage.info
  lcov --extract coverage.info "$SUBJECT/$TARGET.c" -o result.info
  
#读取并计算result.info中的行覆盖率信息，写入data.txt中
/usr/bin/python3 <<-eof
file_read = open("result.info",'r')
lines = file_read.readlines()
file_read.close()
LF = lines[-3].split(':')[1]
LH = lines[-2].split(':')[1]
data = int(LH)/int(LF)
file_write = open("../data.txt",'a')
file_write.write(str($idx))
file_write.write(":")
file_write.write(str(data*100))
file_write.write("%\n")
file_write.close()
eof

  cd ..
done


