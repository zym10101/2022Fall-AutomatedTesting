run_readelf.sh/run_objdump.sh/run_cxxfilt.sh/run_nm.sh/run_size.sh:
运行fuzzing：binutils的某个项目，参数有两个 <START_IDX> <REPEAT>，每一轮执行1小时
run_all.sh:
运行fuzzing：binutils的全部项目，参数默认为 0 1，每个项目执行1轮，即1小时，共需5小时
run_xmllint.sh:
运行fuzzing：libxml2的xmllint，参数有两个 <START_IDX> <REPEAT>，每一轮执行1小时
