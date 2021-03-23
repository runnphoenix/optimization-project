#!/usr/bin/env python3

import os
import glob
from datetime import datetime
import time

def solve_one_instance(data_file, process_time):
	file_name = data_file.split('/')[-1][:-4]
	result_file = '../out/' + file_name + '-out.txt'
	
	with open(result_file, 'w+') as rf: # 'w+' for rewriting to all files
		contents = rf.readlines()
		# tell if this file already contains the result, only works when open a file with 'r' option
		if len(contents) <= 1: # no results
			start_time = time.time()
			process = os.popen('minizinc ' + '--solver Gecode ' + '-o ' + result_file + ' -t ' + '300000 ' + '-p ' + '4 ' + 'PWP.mzn ' + data_file)
			response = process.read()
			end_time = time.time()
			process_time[file_name] = end_time - start_time
			process.close()
	
			print(process_time)

def main():
	process_time = {}
	
	list_of_files = sorted(glob.glob('../../instances/*.dzn'))
	for data_file in list_of_files:
		print("Processing " + data_file + "...")
		solve_one_instance(data_file, process_time)
	
if __name__ == '__main__':
	main()
