#!/usr/bin/env python3

import glob

def sort_key(line): 
	#return line[0] * line[1] # sort array according to the product of elements
	return line[1] # sort array according to the height of each rectangle
	
def read_file(file_name):
	with open(file_name, 'r') as FI:
		line1 = FI.readline()
		wh=line1.split()
		w,h = int(wh[0]), int(wh[1])
	
		line2 = FI.readline()
		n = int(line2)

		size_lines = []
		for _ in range(n):
			line = FI.readline()
			wh = [int(e) for e in line.split()] # a list
			size_lines.append(wh)

	#size_lines.sort(key=sort_key, reverse=True)

	ws = []
	hs = []
	for line in size_lines:
		ws.append(line[0])
		hs.append(line[1])
		
	# last first of original dimensions
	ws = ws[::-1]
	hs = hs[::-1]
	
	return w,h,n,ws,hs
	
def write_dzn(file_name, w, h, n, ws, hs):
	with open(file_name.replace('txt', 'dzn'), 'w') as FO:
		FO.write("W = %d;\n" % w)
		FO.write("H = %d;\n" % h)
		FO.write("N = %d;\n" % n)
		FO.write("Ws = %s;\n" % ws)
		FO.write("Hs = %s;" % hs)

def main():
	list_of_files = glob.glob('../../instances/*.txt')   # the list of files to be converted
	for file_name in list_of_files:
		# Read txt file
		w,h,n,ws,hs = read_file(file_name)
		# write to dzn file
		write_dzn(file_name,w,h,n,ws,hs)
		
if __name__ == '__main__':
	main() 
