#!/bin/bash

mkdir image
afl-plot . image
firefox image/index.html
