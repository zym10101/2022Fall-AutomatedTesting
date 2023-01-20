fuzz 分组工具afl.py/afl++.py:
读取afl-fuzz和afl++-fuzz的收集到的queue中的用例，按照时间（分钟）进行分组，生成60个文件夹，每个文件夹存放该分钟内新变异的用例
以afl-fuzz readelf为例：使用时将该afl.py文件放在fuzz_data/afl/readelf目录下
