fuzz绘图工具 fuzz-draw.sh：
fuzz结果的图形化展示，使用了afl-plot工具，展示了total_paths/current_path/pending_paths/pending_favs/cycles_done/uniq_crashes/uniq_hangs/levels/execs_speed 等数据随时间的变化曲线
使用说明：将该脚本文件放到fuzz_out目录下（该目录下必须含有plot_data文件）
