function [c, d] = sateval( nots, over, int, nint, cp, cc, nc, Lo)
% Vectorized, functional version of sat indicator evaluation.
% All loops could be eliminated with the  proper use of 'meshgrid ' but this risks causing memory overflows.
% Caution: 'imaging' the outputs may still cause problems for large parameter values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dim = length(int); flag = 0;
if isempty( over )
    literals = bitxor(nots, int); flag = 1;   
    chi = indicator( literals, cp, cc, nc, dim, flag);    
    Filter = int;
else
    c = zeros(1, dim);d = c; 
    psi = filtrate( int, nint, over, Lo, dim );
    Filter = find( psi == 1 ); 
    literals = bitxor(nots, Filter ); 
    chi = indicator( literals, cp, cc, nc, dim, flag);     
end
c(Filter) = all( 1 - chi, 1 ); d(Filter) = any( chi, 1 );
end

function psi = filtrate( int, nint, over, Lo, dim )
psi1 = ones(1, dim); psi2 = psi1; periods = 2.^(over - 1); 
for i=1:Lo 
    psi1 = psi1.*eta( int, periods(i), periods(i), 1 ); 
    psi2 = psi2.*eta( nint, periods(i), periods(i), 1 ); 
end
psi = psi1 + psi2;
end

function chi = indicator(literals, cp, cc, nc, dim, flag)
if flag, chi = zeros(nc, dim); else chi = zeros(nc, length(literals)); end
for i=1:nc,  chi(i, :) = floor( mod( floor( literals/cp(i) ), cc(i) )/( cc(i) - 1) ); end
end