import glob

list_of_files = glob.glob('./*.txt')           # create the list of file
for file_name in list_of_files:
	# Read the txt file
	FI = open(file_name, 'r')
	
	line1 = FI.readline()
	wh=line1.split()
	w,h = int(wh[0]), int(wh[1])
	
	line2 = FI.readline()
	n = int(line2)
	
	wi = []
	hi = []
	for _ in range(n):
		line = FI.readline()
		wh = line.split()
		wi.append(int(wh[0]))
		hi.append(int(wh[1]))
		
			
	# write to dzn file
	FO = open(file_name.replace('txt', 'dzn'), 'w') 
	FO.write("w = %d;\n" % w)
	FO.write("h = %d;\n" % h)
	FO.write("n = %d;\n" % n)
	FO.write("wi = %s;\n" % wi)
	FO.write("hi = %s;" % hi)
	
	FI.close()
	FO.close()