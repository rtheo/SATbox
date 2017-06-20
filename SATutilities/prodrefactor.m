function prodrefactor( L )
% Equivalence of the flipped 2^L x 2^L fractal bitwise-OR matrix with the product
% formulas in the general overlap indicator function.
clc, clf, close all
dim = 2^L; w = WD( L, 2 );winv = flipud( w );
p1 = []; p2 = p1; p3 = p2; p4 = p3;
rowptr = 1:L; SL = 0:dim-1; invSL = dim-1:-1:0;
for i=1:dim - 1 % avoid first zero word
    % equivalence of overlap filter with dictionary self-sampling;
    tmp = w(i+1, :).*rowptr; sampler = tmp( tmp > 0 ); %all indices of one bits
    p1 = [p1; prod( w( :, sampler ), 2 )' ];
    p2 = [p2; prod( winv( :, sampler ), 2 )' ];
     %test against original version of overlap filter
    tmp1 = ones(1, dim); tmp2 = tmp1; 
    p = 2.^(sampler-1); ls = length(sampler); 
    for j=1:ls                                       
        tmp1 = tmp1.*eta( SL, p(j), p(j), 1 );
        tmp2 = tmp2.*eta( invSL, p(j), p(j), 1 ); 
    end
    p3 = [p3; tmp1 ];  p4 = [p4; tmp2 ];  
end
filter1 = p1 + p2 == 1; 
figure(1), imagesc( p1); colormap gray
figure(2), imagesc( p2 ); colormap gray
figure(3), imagesc( filter1 ); colormap gray
title('Alternate Overlap Filter (PRESS ANY KEY)'), xlabel 'SAT instances', ylabel 'Overlap Codes'
pause, clc, clf, close all
filter2 = p3 + p4 == 1; 
figure(1), imagesc( p3); colormap gray
figure(2), imagesc( p4 ); colormap gray
figure(3), imagesc( filter2 ); colormap gray
df1 = filter2 - filter1;sdf = sum(df1(:));
title(['Alternate Overlap Filter: total difference ',num2str( sdf ),'(PRESS ANY KEY)']), xlabel 'SAT instances', ylabel 'Overlap Codes'
pause, clc, clf, close all
% test bitwise-OR version of overlap filter
[u, v] = meshgrid(0:dim-1, 1:dim-1);
t1 = bitor(u, dim - v - 1 ) == dim-1;
t2 = bitor(dim - u - 1, dim - v - 1) == dim-1;
filter3 = t1 + t2 == 1; 
df2 = (filter2 - filter3)'; sdf = sum( df2(:) );
figure(4), imagesc( t1 ), colormap gray
figure(5), imagesc( t2 ), colormap gray
figure(6), imagesc( filter3 ); colormap gray
title(['bitwiseOR version for Overlap Filter: total differences ',num2str( sdf )]), xlabel 'SAT instances', ylabel 'Overlap Codes'
end