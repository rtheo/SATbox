function [cnf, dnf] = sateval( clauses, nots, ocodes,L, option )
save = bin2dec( num2str( floor( (nots + 1)/2 ) ) ); %floor( (nots + 1)/2 )*(2.^(0:L-1))';
dim = 2^L; int = 0:dim-1;overset = ones(1, dim);
if ~isempty(ocodes)
    overset = trimmer( int, dim - int - 1, ocodes, dim - ocodes - 1 );
end
runlength = (dim - 2)*option + 1; 
dnf = zeros( runlength+option, dim );cnf = dnf;  
cnfset = UIeval( int, clauses, 0);
dnfset = UIeval( int, clauses, 1);
for nots = 1-option:runlength
    if runlength==1, arg = save; else arg = nots; end
    literals = bitxor( int, arg ); 
    cnf( nots+option, :) = overset( literals+1 ).*cnfset( literals+1 ); 
    dnf( nots+option, :) = overset(literals+1).*dnfset(literals+1); 
end
end