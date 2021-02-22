include "globals.mzn";

%% Inputs and Variables
int: W;  % width of the whole paper
int: H;  % height of the whole paper
int: N;  % number of small pieces
set of int: width = 0..W;
set of int: height = 0..H;
set of int: count = 1..N;
array[count] of int: Ws;  % widths of small pieces
array[count] of int: Hs;  % heights of small pieces
array[count] of var 0..(W-1): Xs;  % coordinates of left-bottom corners
array[count] of var 0..(H-1): Ys;

% Assert the input data are all valid: sum(Wi * Hi) <= W * H
constraint assert( sum(i in count) (Ws[i] * Hs[i]) <= W * H, "Total area of all small pieces should not be bigger than the big one." );

% Symmetry breaking
constraint lex_lesseq(Xs, reverse(Xs));
constraint lex_lesseq(Ys, reverse(Ys));

% 1. Main problem constriants
% Xi + Wi <= W, Yi + Hi <= H
constraint forall(i in count) (Xs[i] + Ws[i] <= W /\ Ys[i] + Hs[i] <= H);
% No overlap
% constraint forall(i,j in count where i<j) (Xs[i] >= Xs[j] + Ws[j] \/ Xs[i] + Ws[i] <= Xs[j] \/
%                                              Ys[i] >= Ys[j] + Hs[j] \/ Ys[i] + Hs[i] <= Ys[j]);

% 2. Implied Constraints
% constraint forall(x in width) (
%              sum(i in count where Xs[i] <= x /\ x < Xs[i] + Ws[i]) (Hs[i]) <= H );
% constraint forall(y in height) (
%              sum(i in count where Ys[i] <= y /\ y < Ys[i] + Hs[i]) (Ws[i]) <= W );

% 3. Global constraints Version
% No overlap between small pieces 
constraint diffn(Xs, Ys, Ws, Hs);
% Implied contraint
constraint cumulative(Xs, Ws, Hs, H);
constraint cumulative(Ys, Hs, Ws, W);

% 4. Search
ann: search_ann;
search_ann = int_search(Xs++Ys, dom_w_deg, indomain_min, complete);
% search_ann = int_search(Xs++Ys, first_fail, indomain_min, complete);
% search_ann = int_search(Xs++Ys, dom_w_deg, indomain_random, complete);
% search_ann = int_search(Xs++Ys, first_fail, indomain_random, complete);

solve 
  :: search_ann
  %:: restart_luby(25)
  satisfy;

% 5. Rotation allowed
% we need to set a new bool variable Oi
% width <-> Height if Oi is true

% 6. multiple pieces of same dimentions
% if there are multiple pieces with same dimension, they should be closed to each other
% or grouped together to form a bigger piece

% 7. OUTPUT TO A FILE
% could be done in command line with a -o option

