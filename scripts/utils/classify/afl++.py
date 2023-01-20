#!/usr/bin/python3.8
import os
import shutil


def mkdir(path):
    folder = os.path.exists(path)
    
    if not folder:
        os.makedirs(path)


if __name__ == '__main__':
    mkdir("results")
    for i in range(1, 61):
        mkdir("results/" + str(i))

    for filename in os.listdir('queue'):
        if not filename.startswith("id"):
            continue
        arr = filename.split(',')
        if arr[0] == "id:000000":
            for j in range(1,3):
                shutil.copy('queue' + '/' + filename, 'results/' + str(j))
            continue
        time = arr[2]
        i = int(int(time[5:]) / 60000)
        if i > 59:
            shutil.copy('queue' + '/' + filename, 'results/' + str(60))
        else:
            shutil.copy('queue' + '/' + filename, 'results/' + str(i+1))
