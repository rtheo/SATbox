function [cnf, dnf, cflag, dflag] = satequalize( file, clauses )
% Turns all clauses to new ones of equal length by adding ones as d0, d1,...dk,1,1,1... 
% Every last ones block of length Max(clauses) - clauses(i) is easily recognisable as 
% a binary shifted Mersenne number by an appropriate filter. Natural periodicity restricts
% all relevant subintervals near the end of [0...2^mc] for each digit in the larger base.
% Any overlaps are separately filtered excluding more values from the total search interval. 
% The core evaluator follows the simple rules
% CNF : All digits must be > 0
% DNF: At least one digit must be a Mersenne number 2^mc - 1
[nc, mc] = size(file);
total = nc*mc;
newRadix = 2^mc;
newRange = 2^total;
cvals = mc - clauses; 
bounds = 2.^cvals - 1; % data for Mersenne detector
eqnots = (file < 0)*(2.^(0:mc-1))';
f = reshape( abs(file)', 1, total );
fu = unique( f ); Lu = length(fu);
if fu(1)==0, fu = fu(2:end); Lu = Lu - 1; end
ovec = zeros(1, Lu); % extract overlap codes for trimming filter
for i=1:Lu 
    tmp = zeros(1, total);  
    tmp( find( f == fu( i ) ) ) = 1; 
    oveq(i) = tmp*( 2.^(0:total-1) )'; 
end
% Main Loop
%disp(file)
%disp(bounds), disp(eqnots), disp(oveq), pause
cnf = []; dnf = [];
k1 = 0;k2 = 0; b = newRadix; 
for i=0:newRange-1         
    seq = rotor( i, newRadix, nc ); 
    if sum( bsxfun( @ge, seq, bounds ) ) == nc % Mersenne end block detector  
        if  trimmer( i, newRange - i - 1, oveq  );         
            for j=1:nc, seq(j) =  bitxor(seq(j), eqnots(j) ) ;  end  % apply negations            
            d = ~isempty( find( seq == newRadix - 1 ) ); 
            if d, k1 = k1 + 1; dnf(k1) = d; end
            c = isempty( find( seq == 0 ) );
            if c, k2 = k2 + 1; cnf(k2) = d; end
        end
    end
end
cflag = 1; dflag = 1;
if isempty(cnf), disp('CNF expression unsatisfiable!'), cflag = 0; end
if isempty(dnf), disp('DNF expression unsatisfiable!'), dflag = 0; end
end