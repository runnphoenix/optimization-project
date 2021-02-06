from z3 import *

# read input of W,H,N,Ws,Hs
# Read directly from txt files
with open("./40x40.txt", 'r') as Fi:
	line1 = Fi.readline()
	wh = line1.split()
	W,H = int(wh[0]), int(wh[1])
	
	line2 = Fi.readline()
	N = int(line2)
	
	Ws = []
	Hs = []
	for _ in range(N):
		line = Fi.readline()
		wh = line.split()
		Ws.append(int(wh[0]))
		Hs.append(int(wh[1]))
		
	Fi.close()


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
# TODO: This is incorrect
implied_X_c = [ Sum([ If(And(Xs[i]<=x, x<Xs[i]+Ws[i]), Hs[i], 0) for i in range(N) ]) <= H for x in range(W)]
implied_Y_c = [ Sum([ If(And(Ys[j]<=y, y<Ys[j]+Hs[j]), Ws[j], 0) for j in range(N) ]) <= W for y in range(H)]

PWP_c = Xi_c + Yi_c + X_W_c + Y_H_c + disjunctive_c + implied_X_c + implied_Y_c

# solve
s = Solver()
s.add(PWP_c)

print(s.check())

if(s.check() == sat):
	m = s.model()
	for i in range(N):
		print("Xs= %s" % m[Xs[i]])
	for i in range(N):
		print("ys= %s" % m[Ys[i]])