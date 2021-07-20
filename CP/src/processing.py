#!/usr/bin/env python3

import os
import glob
from datetime import datetime
import time


def solve_one_instance(input_file, process_time):
	file_name = input_file.split('/')[-1][:-4]        # get file name from input file location
	result_file = '../out/' + file_name + '-out.txt'  # location of output file
	
	with open(result_file, 'w+') as rf:   # 'w+' for rewriting the files
		contents = rf.readlines()
		
		start_time = time.time()
		process = os.popen('minizinc ' + '--solver Gecode ' + '-o ' + result_file + ' -t ' + '300000 ' + '-p ' + '4 ' + 'PWP.mzn ' + input_file)
		response = process.read()
		end_time = time.time()
		process_time[file_name] = end_time - start_time
		process.close()

		print(process_time)


def main():
	process_time = {} # the dictionary storing all the processing time
	
	list_of_files = sorted(glob.glob('../../instances/*.dzn'))
	for input_file in list_of_files:
		print("Processing " + input_file + "...")
		solve_one_instance(input_file, process_time)
	
if __name__ == '__main__':
	main()