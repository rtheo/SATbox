function [cnf, dnf] = sateval( clauses, nots, ocodes, dim, option )
save = bin2dec( num2str( floor( (nots + 1)/2 ) ) ); %floor( (nots + 1)/2 )*(2.^(0:L-1))';
int = 0:dim-1;overset = int;
nc = length( clauses );
runlength = (dim - 2)*option + 1; 
cc = 2.^clauses; cs = 2.^cumsum( [0, clauses] );
dnf = zeros( runlength+option, dim );cnf = dnf;  
if ~isempty(ocodes)
    % Valid for SAT2-3: functional composition of negations on overlaps necessary
    overset = trimmer( int, dim - int - 1, ocodes, dim - ocodes - 1 );
    for nots = 1-option:runlength
        if runlength==1, arg = save; else arg = nots; end
        literals = bitxor( overset, arg ); 
        cnf( nots+option, :) = UIeval( literals, cs, cc, 0); 
        dnf( nots+option, :) = UIeval( literals, cs, cc, 1);
    end
else
    % Valid for SAT0-1: No reason to apply the indicator more than once - negations:=permutations
    cnfset = UIeval( int, clauses, 0);
    dnfset = UIeval( int, clauses, 1);
    for nots = 1-option:runlength
        if runlength==1, arg = save; else arg = nots; end
        literals = bitxor( int, arg ); 
        cnf( nots+option, :) = cnfset(literals+1); 
        dnf( nots+option, :) = dnfset(literals+1); 
    end
end
end
