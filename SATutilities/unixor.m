function y = unixor( x, level)
% returns a single swap of an input sequence x 
% for a single bit of the negation map at level "lev".
period = 2^(level-1); 
ptr = 0:length(x)-1;
y = zeros(1, length(x));
% extract swap indices with Boolean filtering
tmp = eta( ptr, period, period ); 
ptr1 = tmp.*(ptr+1); 
ptr2 = (1 - tmp).*(ptr+1);
ptr1 = ptr1( ptr1>0 ); 
ptr2 = ptr2( ptr2>0 );
y( ptr1 ) = x( ptr2 ); 
y( ptr2 ) = x( ptr1 ); 
end