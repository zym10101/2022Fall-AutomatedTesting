gcov.sh:
按fuzz_data的分组运行、分组读取并计算覆盖率信息，并将覆盖率写入data.txt中
使用说明：
1.使用前须确保项目经过gcov插桩编译。以binutils为例：
（1）插桩：在binutils-2.39目录下执行：./configure CC=/usr/local/bin/gcc CFLAGS="-fprofile-arcs -ftest-coverage" LIBS=-lgcov
（2）编译：在binutils-2.39目录下执行：make
2.将该脚本放在项目根目录下，我的是“/home/zym/桌面/gcov-project/binutils-2.39/binutils”
3.需要输入两个参数：使用的fuzzer、被测试的工具名称，例如：./gcov.sh afl readelf
4.data.txt文件生成在“根目录/gcov_data/afl/readelf”中
