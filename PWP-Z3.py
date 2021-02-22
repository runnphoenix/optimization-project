from z3 import *
import glob
import time

def solve(W,H, N, Ws, Hs, file_name):
	# creating variables
	Xs = [Int("X%i" % i) for i in range(N)]
	Ys = [Int("Y%i" % i) for i in range(N)]
	
	# add 'constraints'
	# 0 <= Xi,Yi < W,H
	Xi_c = [And(0 <= Xs[i], Xs[i] < W) for i in range(N)]
	Yi_c = [And(0 <= Ys[i], Ys[i] < H) for i in range(N)]
	
	# Xi + Wi <= W, Yi + Hi <= H
	X_W_c = [(Xs[i] + Ws[i] <= W) for i in range(N)]
	Y_H_c = [(Ys[i] + Hs[i] <= H) for i in range(N)]
	
	# sum(Hi*Wi) <= W*H
	# NOT usable, as these are all input constants
	square_c = [ Sum([Ws[i] * Hs[i] for i in range(N)]) <= W*H ]
	
	# no overlap
	disjunctive_c = [Or(Xs[i] >= Xs[j] + Ws[j], Xs[i] + Ws[i] <= Xs[j], Ys[i] >= Ys[j] + Hs[j], Ys[i] + Hs[i] <= Ys[j]) 
						for i in range(N) for j in range(N) if i != j]
	
	# implied constraint
	implied_X_c = [ Sum([ If(And(Xs[i]<=x, x<Xs[i]+Ws[i]), Hs[i], 0) for i in range(N) ]) <= H for x in range(W)]
	implied_Y_c = [ Sum([ If(And(Ys[j]<=y, y<Ys[j]+Hs[j]), Ws[j], 0) for j in range(N) ]) <= W for y in range(H)]
	
	PWP_c = Xi_c + Yi_c + X_W_c + Y_H_c + disjunctive_c + implied_X_c + implied_Y_c
	
	# solve
	s = Solver()
	s.add(PWP_c)
	
	print(s.check())
	
	if(s.check() == sat):
		m = s.model()
		print( [m.evaluate(Xs[i]) for i in range(N)] )
		print( [m.evaluate(Ys[i]) for i in range(N)] )
		#TODO: write to output files
		
# Read input form txt files
input_files = glob.glob("./*.txt")
for file_name in input_files:
	with open(file_name) as F:
		line1 = F.readline()
		wh = line1.split()
		W,H = int(wh[0]), int(wh[1])
		
		line2 = F.readline()
		N = int(line2)
		
		Ws = []
		Hs = []
		for _ in range(N):
			line = F.readline()
			wh = line.split()
			Ws.append(int(wh[0]))
			Hs.append(int(wh[1]))
			
		print(file_name)
		start_time = time.time()
		solve(W,H,N,Ws,Hs,file_name)
		end_time = time.time()
		print(end_time - start_time) # time used for each problem
		
		F.close()