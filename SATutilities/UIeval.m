function chi = UIeval( literals, cs, cc, nc, flag)
% SAT universal indicator function, flag (0/1): CNF/DNF
chi = zeros( 1, length(literals) );
for i=1:nc, chi = chi + indicatrix(  mod( floor( literals/cs(i) ), cc(i) ), cc(i) - 1, flag ); end
if flag, chi = chi > 0; else chi = floor( chi/nc ); end
end

function y = indicatrix( x, cc, flag )
if flag,  y = 1 - floor( 1 - x./cc ); else y = floor( x./cc ); end
end
