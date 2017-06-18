function [c, d] = sateval( nots, p, over, int, nint, cp, cc, nc)
% Vectorized, functional version of sat indicator evaluation.
% All loops could be eliminated with the  proper use of 'meshgrid ' but this risks causing memory overflows.
% Caution: 'imaging' the outputs may still cause problems for large parameter values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dim = length(int); flag = 0;
if isempty( p )
    literals = bitxor(nots, int); flag = 1;   
    chi = indicator( literals, cp, cc, nc, dim, flag);    
    Filter = int;
else
    c = zeros(1, dim);d = c; 
    psi = filtrate( int, nint, p, over, dim );
    Filter = find( psi == 1 ); 
    literals = bitxor(nots, Filter ); 
    chi = indicator( literals, cp, cc, nc, dim, flag);     
end
c(Filter) = all( 1 - chi, 1 ); d(Filter) = any( chi, 1 );
end

function psi = filtrate( int, nint, p, over, dim )
psi = zeros(1, dim); k = 1;
for i=1:length(over)
    tmp1 = ones(1, dim); tmp2 = tmp1; 
    for j=1:over(i) 
        tmp1 = tmp1.*eta( int, p(k), p(k), 1 ); tmp2 = tmp2.*eta( nint, p(k), p(k), 1 ); k = k + 1;
    end
    psi = psi + tmp1 + tmp2;
end
end

function chi = indicator(literals, cp, cc, nc, dim, flag)
if flag, chi = zeros(nc, dim); else chi = zeros(nc, length(literals)); end
for i=1:nc,  chi(i, :) = floor( mod( floor( literals/cp(i) ), cc(i) )/( cc(i) - 1) ); end
end