#!/usr/bin/env python3

import numpy as np
import sys

def get_test_file_location():
	args = sys.argv
	if len(args) < 2:
			print("Please input the location of the input file.")
	elif len(args) > 2:
			print("You can only input one input file location as parameter.")
	else:
			test_file_path = sys.argv[1]
			return test_file_path

def get_colored_background(i): # convert a digit to a colored code string
	return "\033[4{}m {:2} \033[0m".format(i%7, i) # 3{}m-forground 4{}m-background, %7 as color of 38m is gray

def print_array(map, row_sep=" "):  # print the colored array
	n, m = map.shape
	fmt_str = "\n".join([row_sep.join(["{}"]*m)]*n)
	print(fmt_str.format(*map.ravel()))
	
def fill_sheet(test_file_path): # fill the sheet with corresponding digits
	with open(test_file_path, 'r') as FI:
		line1 = FI.readline()
		wh=line1.split()
		w,h = int(wh[0]), int(wh[1])
		line2 = FI.readline()
		n = int(line2)
		
		sheet = np.zeros((h,w), dtype=int)
		
		for i in range(n):
			line = FI.readline()
			piece = line.split()
			wi = int(piece[0])
			hi = int(piece[1])
			xi = int(piece[2])
			yi = int(piece[3])
			
			sheet[h-yi-hi:h-yi, xi:xi+wi] = i+1
	return sheet
		
def main():
	test_file_path = get_test_file_location()
	sheet = fill_sheet(test_file_path)
	sheet_modified = np.vectorize(get_colored_background)(sheet)
	print_array(sheet_modified, row_sep="")
	
if __name__ == '__main__':
	main()
