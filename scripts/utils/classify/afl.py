#!/usr/bin/python3.8
import os
import shutil


def mkdir(path):
    folder = os.path.exists(path)

    if not folder:
        os.makedirs(path)


def time(str):
    elements = str.split(',')
    return int(elements[0])


def cnt(str):
    elements = str.split(',')
    return elements[3]


def id(str):
    tmp = str.split(',')
    id_tag = tmp[0].split(':')
    id_str = id_tag[1]
    return int(id_str)


if __name__ == '__main__':
    mkdir("results")
    for i in range(1, 61):
        mkdir("results/" + str(i))

    plot = open("plot_data", 'r')
    listOfLines = plot.readlines()
    plot.close()

    arr = [0]
    for i in range(2, len(listOfLines)):
        start_time = time(listOfLines[1])
        if len(arr) == 60:
            break
        if int((time(listOfLines[i - 1]) - start_time) / 60) < int((time(listOfLines[i]) - start_time) / 60):
            if len(arr) * 60 - (time(listOfLines[i]) - start_time) > (time(listOfLines[i + 1]) - start_time) - len(arr) * 60:
                arr.append(cnt(listOfLines[i]))
            else:
                arr.append(cnt(listOfLines[i - 1]))

    fileList = os.listdir("queue")
    for file in fileList:
        if not file.startswith("id"):
            continue
        if id(file) == 0:
            shutil.copy("queue/" + file, "results/1")
        else:
            index = id(file)
            flag = 0
            directory = 0
            for i in range(1, 60):
                if int(arr[i - 1]) < index <= int(arr[i]):
                    directory = i
                    flag = 1
            if flag == 0:
                directory = 60
            shutil.copy("queue/" + file, "results/" + str(directory))
