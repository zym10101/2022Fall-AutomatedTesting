gcov绘图工具 main.py：
gcov逐分钟结果的图形化展示，使用了mathplotlib库，展示了覆盖率数据随fuzz时间的变化曲线
使用说明：将该文件放到results目录下（该目录下必须含有data.txt文件）

gcov绘图工具 compare.py：
两个工具的gcov逐分钟结果对比的图形化展示
使用说明：将该文件与同项目不同工具的两个data.txt文件放于同一个目录下，txt文件分别改名为afl.txt和afl++.txt