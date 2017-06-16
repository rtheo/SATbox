function [vf, c] = Sieve( j, p, type )
% A sieve for isolating recursive sequences for the SAT-SDS problem
% j: number of equalized clauses
% p: maximal clause length
% type: (1) xor sequences, (2) and sequences, (3) or sequences
% vf: Block Analysis of final indicator
% c: 2 x b^n array of restricted 2-integer composits per valid trajectory
% WARNING: Memory overflow risk for high j, p values!
clc, close all
n = 2*j - 1; b = 2^p;
disp(['Radix = ', num2str(b), ', Expansion length = ',num2str( n ),', Total binary log: ',num2str(p*n) ])
Ps = zeros(1, b^n);k = 0;
for i=0:b^n - 1 
    s = rotor( i, b, n ); 
    Ps(i+1) = operator( s, j, type ); 
    if Ps(i+1), k=k+1; [c(1, k), c(2, k)] = reconstruct( s, b, n );end
end
disp([num2str( sum( Ps )),' valid trajectories in total of ',num2str( b^n-1 )])
[cf vf]=blockanalysis( Ps ); cp = length( vf(vf>0) ); cn = length( vf(vf<0) ); 
disp(['Block analysis: ', num2str(cp),' positive ',num2str(cn),' negative'])
% use figure at risk of memory overflow or break output for separate viewing
%figure(2),bar( vf ), title( [num2str( cf ),' total blocks: ', num2str(cp),' positive ',num2str(cn),' negative'])
end

function val = operator( s, j, type )
switch type
    case 1, val = ( sum( bitxor( s(1:2:end-2 ), s(2:2:end-1) ) == s(3:2:end) ) == (j - 1) ); 
    case 2, val = ( sum( bitand( s(1:2:end-2 ), s(2:2:end-1) ) == s(3:2:end) ) == (j - 1) ); 
    case 3, val = ( sum( bitor( s(1:2:end-2 ), s(2:2:end-1) ) == s(3:2:end) ) == (j - 1) ); 
end
end

function [a b] = reconstruct( s, b, n )
base1 = b.^[0, 1:2:n-1]; s1 = [s(1), s(2:2:n)];
base2 = b.^(2:2:n-1); s2 = s(3:2:n);
a = sum(s1.*base1); 
b = sum(s2.*base2);
%disp( a+b )
end