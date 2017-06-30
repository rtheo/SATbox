function psi = trimmer( int, nint, oc, noc )
% Search space trimming filter for overlaps
no = length(oc); psi = zeros(1, length(int));
for i=1:no
    psi = psi + ( bitand( int, noc(i) ) == noc(i) ) + ( bitand( nint, noc(i) ) == noc(i) ); 
end
psi = floor( psi/no );
end
