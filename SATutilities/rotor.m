function [sym, num] = rotor(n, b, nrot, seq)
% n:=       integer to be decoded
% b: =      alphabet basis
% nrot:=   number of rotations
% seq:= | (0) output as symbolic string sym 
%          | (1) output as array of all integers w in same cyclic group
if nargin<4, seq=0; end
if seq>1, error('4th arg must be Boolean!'), end
dim = b^(nrot-1);
sym = zeros(1,nrot);
sym(1) = mod(n, b);
if seq, num(1) = n;end
for i=2:nrot    
    n=floor(n/b) + sym(i-1)*dim;
    sym(i) = mod(n, b);
    if seq, num(i) = n;end
end
end