include "globals.mzn";

%% Inputs
int: W;  % width of the whole paper
set of int: width = 0..(W-1);
int: H;  % height of the whole paper
set of int: height = 0..(H-1);
int: N;  % number of small pieces
set of int: numbers = 1..N;

array[numbers] of int: Ws;  % widths of small pieces
array[numbers] of int: Hs;  % heights of the small pieces

% TODO: assert the input data are all valid
% 0.2 sum(Wi * Hi) <= W * H
% constraint sum(i in numbers) (Ws[i] * Hs[i]) <= W * H;

%% Variables
% coordinates of left-bottom corners 
array[numbers] of var 0..(W-1): Xs;
array[numbers] of var 0..(H-1): Ys;

% 1. Main problem constriants
% 1.1 W > Xi >= 0, H > Yi >=0
% redandunt because there's already constriant in definition
% constraint forall(x in Xs) (0 <= x /\ x < W);
% constraint forall(y in Ys) (0 <= y /\ y < H);

% 1.2 Xi + Wi <= W, Yi + Hi <= H
constraint forall(i in numbers) (Xs[i] + Ws[i] <= W /\ Ys[i] + Hs[i] <= H);

% 1.3 No overlap
% constraint forall(i,j in numbers where i<j) (Xs[i] >= Xs[j] + Ws[j] \/ Xs[i] + Ws[i] <= Xs[j] \/
%                                              Ys[i] >= Ys[j] + Hs[j] \/ Ys[i] + Hs[i] <= Ys[j]);

% 1.3.1 Global Constraint version  TODO: This one is wrong
% constraint disjunctive(Xs, Ws) \/ disjunctive(Ys, Hs);

% 1.4 Symmetry
%constraint lex_lesseq();

% 2. Implied Constraints

% constraint forall(x in width) (
%              sum(j in numbers where Xs[j] <= x /\ x < Xs[j] + Ws[j]) (Hs[j]) <= H );
% constraint forall(y in height) (
%              sum(j in numbers where Ys[j] <= y /\ y < Ys[j] + Hs[j]) (Ws[j]) <= W );

% 2.1 Global constraint version
constraint cumulative(Xs, Ws, Hs, H) /\ cumulative(Ys, Hs, Ws, W);

% 4. Search
ann: search_ann;
search_ann = int_search(Xs++Ys, dom_w_deg, indomain_min, complete);

solve 
  :: search_ann
  %:: restart_luby(25)
  satisfy;

% 5. Rotation allowed
% we need to set a new bool variable Oi
% width <-> Height if Oi is true

% 6. multiple pieces of same dimentions
% if there are multiple pieces with same dimention, they should be closed to each other
% or grouped together to form a bigger piece

%% OUTPUT TO A FILE
% could be done in command line with a -o option