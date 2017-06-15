function y = logb( x, b )
%L2 b-ary logarithm
if nargin<2, 
    y = floor( log2( x ) ) + 1;
else
    y = floor( 1 + log2( x )/log2( b ) );
end
end