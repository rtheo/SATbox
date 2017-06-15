function [s s1 s0] = Sdb( xp, b )
% Uniform constructors for the Sum-of-Digits and the Even/Odd Sum-of-Digits 
% sequence in any base via concatenation operators.
% xp --> Exponent for base power interval
% b   --> Alphabet base
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<3, eo = 0; end
s0 = 0; s = s0; 
for i=1:xp, for j=1:b-1,  s = [s, s0+j]; end, s0 = s; end
end