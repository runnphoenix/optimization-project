#!/usr/bin/env python3

from z3 import *
import os
import glob
import time
from numba import jit

@jit(nopython=True)
def sort_key(line): 
	return line[0] * line[1] # sort array according to the product of elements

def read_file(file_name):
	""" read in one instance file """
	with open(file_name) as F:
		line1 = F.readline()
		wh = line1.split()
		W,H = int(wh[0]), int(wh[1])
		
		line2 = F.readline()
		N = int(line2)
		
		size_lines = []
		for _ in range(N):
			line = F.readline()
			size_lines.append([int(x) for x in line.split()])
			
		#size_lines.sort(key=sort_key, reverse=True)
		
		Ws = []
		Hs = []
		for i in range(N):
			Ws.append(size_lines[i][0])
			Hs.append(size_lines[i][1])
			
		Ws = Ws[::-1]
		Hs = Hs[::-1]

	return W,H,N,Ws,Hs

def write_to_file(file_path, W, H, N, Ws, Hs, Xs, Ys, Os):
	""" write the result to a file """
	file_name = file_path.split('/')[-1][:-4]
	out_file_path = os.path.join('..' , 'out', file_name + '-out' + '.txt')
	
	with open(out_file_path, 'w+') as fo:
		fo.write("%s %s\n" % (W,H))
		fo.write("%s\n" % N)
		for i in range(N):
			fo.write("%s %s %s %s %s\n" % (Ws[i], Hs[i], Xs[i], Ys[i], Os[i]))

def solve_one_instance(W, H, N, Ws, Hs, file_name):
	""" the main model """
	# creating variables
	Xs = [Int("X%i" % i) for i in range(N)]
	Ys = [Int("Y%i" % i) for i in range(N)]
	Os = [Int("O%i" % i) for i in range(N)]
	
	# Constraints
	# 0 <= Xi,Yi < W,H
	Xi_c = [And(0 <= Xs[i], Xs[i] < W) for i in range(N)]
	Yi_c = [And(0 <= Ys[i], Ys[i] < H) for i in range(N)]
	Oi_c = [And(0 <= Os[i], Os[i] <= 1) for i in range(N)]
	
	
	# Xi + Wi <= W, Yi + Hi <= H
	X_W_c = [If (Os[i]==0,
				Xs[i] + Ws[i] <= W,
				Xs[i] + Hs[i] <= W)
			for i in range(N) ]
	Y_H_c = [If (Os[i]==0,
				Ys[i] + Hs[i] <= H,
				Ys[i] + Ws[i] <= H)
			for i in range(N) ]
	
	# no overlap
	overlap_c = [If (Os[i]==0,
					Or(Xs[i] >= Xs[j] + Ws[j], Xs[i] + Ws[i] <= Xs[j], Ys[i] >= Ys[j] + Hs[j], Ys[i] + Hs[i] <= Ys[j]),
					Or(Xs[i] >= Xs[j] + Hs[j], Xs[i] + Hs[i] <= Xs[j], Ys[i] >= Ys[j] + Ws[j], Ys[i] + Ws[i] <= Ys[j]))
				for i in range(N) for j in range(i+1,N)]
	
	# All small pieces whose height > H/2 must be placed horizontally
	horizon_c = [(Xs[j]-Xs[i] >= min(Ws[i],Ws[j]))
		for i in range(N) for j in range(i+1,N) if(Hs[i] > H//2 and Hs[j] > H//2)]
	# Two pieces which could form a column should be encouraged to do so
	vertical_c = [Or(Xs[j] - Xs[i] == Ws[i], Xs[j] == Xs[i])
		for i in range(N) for j in range(i+1,N) if(Hs[i]>H//2 and Hs[i]+Hs[j]==H and Ws[i]==Ws[j])]

	# implied constraint
	implied_X_c = [ Sum([ If(And(Xs[i]<=x, x<Xs[i]+Ws[i]), Hs[i], 0) for i in range(N) if Os[i]==0]) <= H for x in range(W)]
	implied_Y_c = [ Sum([ If(And(Ys[j]<=y, y<Ys[j]+Hs[j]), Ws[j], 0) for j in range(N) if Os[j]==0]) <= W for y in range(H)]
	implied_X_c_o = [ Sum([ If(And(Xs[i]<=x, x<Xs[i]+Hs[i]), Ws[i], 0) for i in range(N) if Os[i]==1]) <= H for x in range(W)]
	implied_Y_c_o = [ Sum([ If(And(Ys[j]<=y, y<Ys[j]+Ws[j]), Hs[j], 0) for j in range(N) if Os[j]==1]) <= W for y in range(H)]
	
	#PWP_c = Xi_c + Yi_c + X_W_c + Y_H_c + overlap_c + horizon_c + vertical_c# + implied_X_c + implied_Y_c
	PWP_c = Xi_c + Yi_c + Oi_c + X_W_c + Y_H_c + overlap_c# + implied_X_c + implied_Y_c + implied_X_c_o + implied_Y_c_o
	
	# solve
	s = Solver()
	s.add(PWP_c)
	
	print(s.check())
	if(s.check() == sat):
		m = s.model()
		Xs_evaluated = [m.evaluate(Xs[i]) for i in range(N)]
		Ys_evaluated = [m.evaluate(Ys[i]) for i in range(N)]
		Os_evaluated = [m.evaluate(Os[i]) for i in range(N)]
		
		return Xs_evaluated, Ys_evaluated, Os_evaluated
	return None, None, None

def main():
	process_time = {}
	
	input_files = sorted(glob.glob("../../instances/*.txt"))
	for i in range(2): # put 8x8 and 9x9 at the front of the list
		last = input_files.pop()
		input_files.insert(0, last)
		
	input_files = input_files[:3]
	for file_path in input_files: # read files from instance.txt
		W,H,N,Ws,Hs = read_file(file_path)
		print('\nProcessing ' + file_path)
		
		start_time = time.time()  # start timer
		Xs_evaluated, Ys_evaluated, Os_evaluated = solve_one_instance(W,H,N,Ws,Hs,file_path)
		end_time = time.time()    # time used for each problem
		process_time[file_path.split('/')[-1][:-4]] = end_time - start_time
		if(Xs_evaluated != None):
			write_to_file(file_path, W, H, N, Ws, Hs, Xs_evaluated, Ys_evaluated, Os_evaluated) #write the new values to file
		print(end_time - start_time)
	print(process_time)

if __name__ == '__main__':
	main()