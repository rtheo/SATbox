function chi = UIeval( literals, clauses, flag)
% SAT universal indicator function, flag (0/1): CNF/DNF
chi = zeros( 1, length(literals) );nc = length(clauses);
cc = 2.^clauses; cs = 2.^cumsum( [0, clauses] ); 
for i=1:nc, chi = chi + indicatrix(  mod( floor( literals/cs(i) ), cc(i) ), cc(i) - 1, flag ); end
if flag, chi = chi > 0; else chi = floor( chi/nc ); end
end

function y = indicatrix( x, cc, flag )
if flag,  y = 1 - floor( 1 - x./cc ); else y = floor( x./cc ); end
end