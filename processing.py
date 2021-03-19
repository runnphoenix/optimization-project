#!/usr/bin/env python3

import os
import glob
from datetime import datetime
import time

process_time = {}

list_of_files = sorted(glob.glob('./*.dzn'))

for data_file in list_of_files:
	print("Processing " + data_file + "...")
	file_name = data_file.split('.')[1][1:]
	result_file = file_name + '-out.txt'
	
	start_time = time.time()
	process = os.popen('minizinc ' + '-o ' + result_file + ' -t ' + '120000 ' + '-p ' + '4 ' + 'PWP.mzn ' + data_file)
	response = process.read()
	end_time = time.time()
	process_time[file_name] = end_time - start_time
	
	process.close()
	
	print(process_time)