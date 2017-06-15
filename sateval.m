function [c, d] = sateval( nots, over, int, cp, cc, L, nc, Lo)
% Vectorized, functional version of sat indicator evaluation.
% All loops could be eliminated with the  proper use of 'meshgrid ' but this risks causing memory overflows.
% Caution: 'imaging' the outputs may still cause problems for large parameter values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dim = length(int);
if isempty( over )
    literals = bitxor(nots, int); 
    chi = zeros(nc, dim);
    for i=1:nc,  chi(i, :) = floor( mod( floor( literals/cp(i) ), cc(i) )/( cc(i) - 1) ); end
    c = all( 1 - chi, 1 ); d = any( chi, 1 );
else
    chi = zeros(Lo, dim); c = zeros(1, dim);d = c;
    for i=1:Lo, chi(i, :) = eta( int, over(i), over(i), 1 ); end
    imagesc(chi), colormap gray
    Filter = find( all( chi, 1 ) == 1 ); 
    literals = bitxor(nots, Filter ); 
    chi = zeros(nc, length(literals));
    for i=1:nc,  chi(i, :) = floor( mod( floor( literals/cp(i) ), cc(i) )/( cc(i) - 1) ); end
    c(Filter) = all( 1 - chi, 1 ); d(Filter) = any( chi, 1 );
end
end