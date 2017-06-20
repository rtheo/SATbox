function [c, d] = sateval( nots, over, int, nint, cp, cc, nc, no)
% Vectorized, functional version of sat indicator evaluation.
% All loops could be eliminated with the  proper use of 'meshgrid ' but this risks causing memory overflows.
% Caution: Displaying the outputs may still cause problems for large parameter values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dim = length(int); c = zeros(1, dim);d = c; optr = int+1; flag = 0;
if no > 0, flag = 1; optr = ofilter( int, nint, over, dim, no ); end
literals = bitxor( nots, optr );
chi = indicator( literals, cp, cc, nc, dim, flag); 
c( optr ) = all( 1 - chi, 1 ); d( optr ) = any( chi, 1 );
end

function psi = ofilter( int, nint, oc, dim, no )
psi = zeros(1, dim); 
for i=1:no, psi = psi + ( bitor( int, dim - oc(i) - 1 ) == dim-1 ) + ( bitor( nint, dim - oc(i) - 1 ) == dim-1 ); end
psi = find( psi == 1 );
end

function chi = indicator(literals, cp, cc, nc, dim, flag)
if flag, chi = zeros(nc, length(literals)); else chi = zeros(nc, dim); end
for i=1:nc,  chi(i, :) = floor( mod( floor( literals/cp(i) ), cc(i) )/( cc(i) - 1) ); end
end