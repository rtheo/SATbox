function [c, d] = sateval( clauses, nots, oc, int, nint, nc, no)
% Vectorized, functional version of sat indicator evaluation.
% Caution: Displaying the outputs may still cause problems for large parameter values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dim = length(int); 
ovint = ones(1, dim); psi = zeros(1, dim); chi = psi;
if no > 0, noc = dim - oc - 1; ovint = trimmer( psi, int, nint, oc, noc, dim-1 ); end
literals = bitxor( nots, int ); % apply negation code to atoms
d = ovint.*( UIuniform( chi, literals, clauses, nc, 0 ) > 0 ); 
c = ovint.*floor( UIuniform( chi, literals, clauses, nc, 1 )/nc ); 
%use below line to prove equivalence
%c = c(literals); d = d(literals); % permutation equivalent of negation
end

function psi = trimmer( psi, int, nint, oc, noc, lim )
% Search space trimming filter for overlaps
no = length(oc);
for i=1:no
    %disp( dim - oc(i) - 1 )
    psi = psi + ( bitor( int, noc(i) ) == lim ) + ( bitor( nint, noc(i) ) == lim ); 
end
psi = floor( psi/no );
end

function chi = UIuniform( chi, literals, clauses, nc, flag)
% SAT universal indicator function, flag (0/1): DNF/CNF
cc = 2.^clauses; cs = 2.^cumsum( [0, clauses] ); 
for i=1:nc, chi = chi + indicatrix(  mod( floor( literals/cs(i) ), cc(i) ), cc(i) - 1, flag ); end
end

function y = indicatrix( x, cc, flag )
if flag,  y = 1 - floor( 1 - x./cc ); else y = floor( x./cc ); end
end