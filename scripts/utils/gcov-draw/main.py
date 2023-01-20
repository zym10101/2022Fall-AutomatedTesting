#!/usr/bin/python3.8
from matplotlib import pyplot as plt

if __name__ == '__main__':
    time_stamp = [0]
    coverage = [0]
    file = open('data.txt', 'r', encoding='utf-8')
    lines = file.readlines()
    for line in lines:
        tmp_list = line.split(":")
        time_stamp.append(tmp_list[0])
        accuracy_modified = tmp_list[1][:5]
        coverage.append(float(accuracy_modified))
        
    
    plt.plot(time_stamp, coverage, 'bo-')
    plt.axis('scaled')
    plt.title("Fuzzer's coverage statistics chart over time", fontsize=12)
    plt.xlabel("Execution Time(min)", fontsize=10)
    plt.ylabel("Coverage(%)", fontsize=10)
    plt.tick_params(axis='both', labelsize=8)
    plt.savefig("data")
    plt.show()
