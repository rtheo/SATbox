function y = isMersenne( x )
%equivalent for y = isshift( x + 1 );
y = floor( 1./( mod(x, 2.^logb(x) - 1 ) + 1 ) );
j = find(x==0); y(j) = 1 - y(j); % correction of original zero values
end