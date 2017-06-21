function [c, d] = sateval( clauses, nots, over, int, nint, nc, no)
% Vectorized, functional version of sat indicator evaluation.
% All loops could be eliminated with the proper use of 'meshgrid ' but this risks causing memory overflows.
% Caution: Displaying the outputs may still cause problems for large parameter values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c = zeros(1, length(int) );d = c; optr = int+1; 
if no > 0, optr = oxfilter( int, nint, over, length(int), no ); end
literals = bitxor( nots, optr ); % apply negation code to atoms
cp = 2.^cumsum( clauses - 1 ); cc = 2.^clauses;
c( optr ) = UI( literals, cp, cc, nc, 1); 
d( optr ) = 1 - UI( literals, cp, cc, nc, 0); 
end

function psi = oxfilter( int, nint, oc, dim, no )
% Search space trimming filter for overlaps
psi = zeros(1, dim); 
for i=1:no 
    psi = psi + ( bitor( int, dim - oc(i) - 1 ) == dim-1 );
    psi = psi + ( bitor( nint, dim - oc(i) - 1 ) == dim-1 ); 
end
psi = find( psi == 1 );
end

function chi = UI(literals, cp, cc, nc, flag)
% SAT Universal indicator function
chi = ones(1, length(literals));
for i=1:nc,  
    index = mod( floor( literals/cp(i) ), cc(i) )/( cc(i) - 1); 
    chi = chi.*abs( abs( floor( index - flag ) ) + flag - 1); 
end
end