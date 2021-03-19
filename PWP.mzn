include "globals.mzn";

%% Inputs and Variables
int: W;  % width of the whole paper
int: H;  % height of the whole paper
int: N;  % number of small pieces
array[1..N] of int: Ws;  % widths of small pieces
array[1..N] of int: Hs;  % heights of small pieces
array[1..N] of var 0..(W-1): Xs;  % coordinates of left-bottom corners
array[1..N] of var 0..(H-1): Ys;

% Assert the input data are all valid: sum(Wi * Hi) <= W * H
constraint assert( sum(i in 1..N) (Ws[i] * Hs[i]) <= W * H, "Total area of all small pieces should not be bigger than the big one." );

% Symmetry breaking
constraint lex_lesseq(Xs, reverse(Xs));
constraint lex_lesseq(Ys, reverse(Ys));

% 1. Main problem constriants
% Xi + Wi <= W, Yi + Hi <= H
constraint forall(i in 1..N) (Xs[i] + Ws[i] <= W /\ Ys[i] + Hs[i] <= H);
% No overlap
% constraint forall(i,j in 1..N where i<j) (Xs[i] >= Xs[j] + Ws[j] \/ Xs[i] + Ws[i] <= Xs[j] \/
%                                              Ys[i] >= Ys[j] + Hs[j] \/ Ys[i] + Hs[i] <= Ys[j]);

% 2. Implied Constraints
% constraint forall(x in 0..W) (
%              sum(i in 1..N where Xs[i] <= x /\ x < Xs[i] + Ws[i]) (Hs[i]) <= H );
% constraint forall(y in 0..H) (
%              sum(i in 1..N where Ys[i] <= y /\ y < Ys[i] + Hs[i]) (Ws[i]) <= W );

% 3. Global constraints Version
% No overlap between small pieces 
constraint diffn(Xs, Ys, Ws, Hs);
% Implied contraint
constraint cumulative(Xs, Ws, Hs, H);
constraint cumulative(Ys, Hs, Ws, W);

% 4. Search
ann: search_ann;
%search_ann = int_search(Xs++Ys, dom_w_deg, indomain_min, complete);
% search_ann = int_search(Xs++Ys, first_fail, indomain_min, complete);
search_ann = int_search(Xs++Ys, dom_w_deg, indomain_random, complete);
% search_ann = int_search(Xs++Ys, first_fail, indomain_random, complete);

solve 
%   :: search_ann
  :: seq_search([
             int_search(Xs, dom_w_deg, indomain_random, complete),
             int_search(Ys, dom_w_deg, indomain_random, complete)])
  :: restart_luby(50)
  satisfy;
  
output [
  show_int(2,W), " ", show_int(2,H), "\n",
  show_int(2,N), "\n"];
output [
  show_int(2,Ws[i]) ++ " " ++ show_int(2,Hs[i]) ++ " " ++ show_int(2,Xs[i]) ++ " " ++ show_int(2,Ys[i]) ++ "\n" |
  i in 1..N
];