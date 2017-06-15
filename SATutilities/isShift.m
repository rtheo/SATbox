function y = isShift(x)
y = abs( 2.^logb(x-1) - x );
y = floor( 2.^( -y ) );
end