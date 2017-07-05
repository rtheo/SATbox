function psi = trimmer( int, nint, oc )
% Search space trimming filter for overlaps
no = length(oc); psi = zeros(1, length(int));
for i=1:no
    psi = psi + ( bitand( int, oc(i) ) == oc(i) ) + ( bitand( nint, oc(i) ) == oc(i) ); 
end
psi = floor( psi/no );
end
