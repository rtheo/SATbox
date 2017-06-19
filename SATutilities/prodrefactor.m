function prodrefactor( L )
% Proves the fractality of a 2^L x 2^L matrix for all product
% formulas in the overall overlaps indicator function.
dim = 2^L;
w = WD( L, 2 );
p1 = []; p2 = p1; 
rowptr = 1:L;
invert = dim:-1:1;
for i=1:dim - 1 
    tmp = w(i, :).*rowptr; sampler = tmp( tmp > 0 );
    p1 = [p1, prod( w( :, sampler ), 2 ) ];
    p2 = [p2, prod( w( invert, sampler ), 2 ) ];
end
figure(1), imagesc( p1); colormap gray
figure(2), imagesc( p2 ); colormap gray
figure(3), imagesc( p1 + p2 ); colormap jet
[u, v] = meshgrid(0:dim-1);
figure(4), imagesc(  bitor(dim - u - 1, v ) == dim-1 ), colormap gray
figure(5), imagesc(  bitor(dim - u - 1, dim - v - 1) == dim-1 ), colormap gray
end