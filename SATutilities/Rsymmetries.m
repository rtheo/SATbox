function [pop1, pop2, pop3] = Rsymmetries( up )
% Verify internal symmetries of bitwise operators under total complementation
% of their inputs equivalent to a single left-right flip (n -> 2^L - n - 1), an up-down
% flip ( the same for the 2nd arg) and their combination
clc, clf, close all
for n = 2:up
    dim=2^n; [u, v] = meshgrid(0:dim-1);
    t = bitor(u , v ); pop1( n ) = unique(t + fliplr(t) + flipud(t) + fliplr( flipud(t) ) );
    t = bitand(u , v ); pop2( n ) = unique(t + fliplr(t) + flipud(t) + fliplr( flipud(t) ) );
    t = bitxor(u , v ); pop3( n ) = unique(t + fliplr(t) + flipud(t) + fliplr( flipud(t) ) );    
    p1(n) = 3*(dim-1); p2(n) = dim-1; p3(n) = 2*(dim-1);
end
x = 1:up;
figure(1), hold on, plot(pop1,'.'), plot(pop2,'.r'), plot(pop3,'.g'), 
plot(x, p1, x, p2, x, p3, 'm'), hold off
end