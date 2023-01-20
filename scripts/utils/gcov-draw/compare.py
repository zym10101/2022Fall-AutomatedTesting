#!/usr/bin/python3.8
from matplotlib import pyplot as plt

if __name__ == '__main__':
    time_stamp = [0]
    y1 = [0]
    y2 = [0]
    file1 = open('afl.txt', 'r', encoding='utf-8')
    lines = file1.readlines()
    for line in lines:
        tmp_list = line.split(":")
        time_stamp.append(tmp_list[0])
        accuracy_modified = tmp_list[1][:5]
        y1.append(float(accuracy_modified))
        
    file2 = open('afl++.txt', 'r', encoding='utf-8')
    lines = file2.readlines()
    for line in lines:
        tmp_list = line.split(":")
        accuracy_modified = tmp_list[1][:5]
        y2.append(float(accuracy_modified))
    
    plt.plot(time_stamp, y1, color='b',linestyle='-',marker='o',label='afl')
    plt.plot(time_stamp, y2, color='r', linestyle='--',label='afl++')
    plt.axis('scaled')
    plt.title("Fuzzer's coverage statistics chart over time", fontsize=12)
    plt.xlabel("Execution Time(min)", fontsize=10)
    plt.ylabel("Coverage(%)", fontsize=10)
    plt.tick_params(axis='both', labelsize=8)
    plt.legend()
    plt.savefig("data")
    plt.show()
