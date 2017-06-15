function x = satnegate(d, n)
% d: total search space
% n: negation code
x = 0:d-1;
if n==0, return, end
l2 = logb( n );
if l2 > logb( x(end) ) 
    error([ 'Negation Code out of max. interval (0,..,',num2str(x(end)) ')' ]) 
end
bits = 2.^(0:l2-1);
sptr = find( eta(n, bits, bits,  1) == 1 );
for i=1:length( sptr ), x = unixor(x, sptr(i) ); end
end