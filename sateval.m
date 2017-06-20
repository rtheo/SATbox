function [c, d] = sateval( nots, oc, p, over, int, nint, cp, cc, nc)
% Vectorized, functional version of sat indicator evaluation.
% All loops could be eliminated with the  proper use of 'meshgrid ' but this risks causing memory overflows.
% Caution: 'imaging' the outputs may still cause problems for large parameter values.
% Args for powers (p) and overlap codes (over) become obsolete after simplification of the original sync function 
%as explained in the forthcoming publication. They are put here only for the possibility of a direct comparison.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dim = length(int); flag = 0;
if isempty( p )
    literals = bitxor(nots, int); flag = 1;   
    chi = indicator( literals, cp, cc, nc, dim, flag);    
    psi = int;
else
    c = zeros(1, dim);d = c; 
    psi = ofilter( int, nint, oc, length(over), dim );
     %psi = filtrate( int, nint, p, over, dim ); % old unsimplified version put here for verification purposes     
    literals = bitxor(nots, psi ); 
    chi = indicator( literals, cp, cc, nc, dim, flag);     
end
c( psi ) = all( 1 - chi, 1 ); d( psi ) = any( chi, 1 );
end

function psi = ofilter( int, nint, oc, Lo, dim )
psi = zeros(1, dim); 
for i=1:Lo, psi = psi + ( bitor( dim - oc(i) - 1, int ) == dim-1 ) + ( bitor( dim - oc(i) - 1, nint ) == dim-1 ); end
psi = find( psi == 1 );
end

function chi = indicator(literals, cp, cc, nc, dim, flag)
if flag, chi = zeros(nc, dim); else chi = zeros(nc, length(literals)); end
for i=1:nc,  chi(i, :) = floor( mod( floor( literals/cp(i) ), cc(i) )/( cc(i) - 1) ); end
end

function psi = filtrate( int, nint, p, over, dim )
% Original version of the overlap synchronization function for direct
% comparison with the simplified form based on bitwise disjunction. 
psi = zeros(1, dim); k = 1; 
for i=1:length(over)
    tmp1 = ones(1, dim); tmp2 = tmp1; 
    for j=1:over(i) 
        tmp1 = tmp1.*eta( int, p(k), p(k), 1 ); tmp2 = tmp2.*eta( nint, p(k), p(k), 1 ); k = k + 1;
    end
    psi = psi + tmp1 + tmp2;
end
psi = find( psi == 1 );
end