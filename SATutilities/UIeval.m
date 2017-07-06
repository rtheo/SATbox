function chi = UIeval( literals, cs, cc, nc, flag)
% SAT universal indicator function, flag (0/1): CNF/DNF
chi = zeros( 1, length(literals) );
for i=1:nc, chi = chi + indicatrix(  mod( floor( literals/cs(i) ), cc(i) ), cc(i) - 1, flag ); end
chi = indicatrix( chi, nc, 1 - flag );
end

function y = indicatrix( x, div, flag )
if flag, y = floor( x./div ); else  y = x > 0; end
end
