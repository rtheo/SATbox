function [c, d] = sateval( nots, over, int, cp, cc, nc, Lo)
% Vectorized, functional version of sat indicator evaluation.
% All loops could be eliminated with the  proper use of 'meshgrid ' but this risks causing memory overflows.
% Caution: 'imaging' the outputs may still cause problems for large parameter values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dim = length(int); flag = 0;
if isempty( over )
    literals = bitxor(nots, int); flag = 1;   
    chi = indicator( literals, cp, cc, nc, dim, flag);    
    c = all( 1 - chi, 1 ); d = any( chi, 1 );
else
    c = zeros(1, dim);d = c; notint = dim - int - 1;
    chi = filtrate( int, notint, over, Lo, dim );
    Filter = find( all( chi, 1 ) == 1 ); 
    literals = bitxor(nots, Filter ); 
    chi = indicator( literals, cp, cc, nc, dim, flag);  
    c(Filter) = all( 1 - chi, 1 ); d(Filter) = any( chi, 1 );
end
end

function chi = filtrate( int, notint, over, Lo, dim )
chi = zeros(Lo, dim);
for i=1:Lo, chi(i, :) = eta( int, over(i), over(i), 1 ) + eta( notint, over(i), over(i), 1 ); end
end

function chi = indicator(literals, cp, cc, nc, dim, flag)
if flag, chi = zeros(nc, dim); else chi = zeros(nc, length(literals)); end
for i=1:nc,  chi(i, :) = floor( mod( floor( literals/cp(i) ), cc(i) )/( cc(i) - 1) ); end
end
