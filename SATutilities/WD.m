function [w, s, s1, s0] = WD( L, b, sdb )
% mkWD: A generic constructor for Lexicographically 
% Ordered Word Dictionaries.
% Optionally, it returns several versions of digit-sums
% n:= associated WD interval [0,...,b^n]
% b:= alphabet basis of strings
% sdb: label for additional construction of odd-even digit-sums
if nargin<3, sdb=0; end
if nargin < 2, b = 2; end
[ x, y ] = meshgrid( 0:(b^L)-1, b.^(0:L-1) );
w =  eta( x, y, (b-1)*y, 1 )';
for z=2:b
    w = w + eta( x, z*y, (b-z)*y, 1 )'; 
end
if sdb
    s   = sum(w, 2)';                  % total digit-sum
    s1 = sum(w( :, 1:2:end ), 2)'; % odd digit-sum
    s0 = sum(w( :, 2:2:end ), 2)'; % even digit-sum
else
    s = []; s1 = []; s0 = [];
end
end