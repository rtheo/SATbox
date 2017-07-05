function [s1 s2] = composits( j, p, L, type )
% Restricted 2-Integer composition in the recursive SAT-SDS sequences;
% Uses a lumping window over distinct triplets to locate all instances of
% X_3 <-- XOR(X1, X2) and its (2^L) - X3 complements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<4, type=1; end
if type<1 || type>3, error('4rth arg out of bounds! (1 - 3)'), end
clc, clf, close all
n = 2*j - 1;b = 2^p;
disp(['Radix: ', num2str(b),' Length: ', num2str(n)  ])
base = (b.^(0:n-1));
idx1 = 3:2:n;           % Digit pointers for kappa integres
idx2 = [ 1, 2:2:n];    % Digit pointers for mu integers
s1 = zeros(1, L); s2 = s1;
for i=1:L
    Kappa    = prod( mod(i, base( idx2 ) ) );
    complement = i - Kappa;
    if prod( mod( complement, base( idx1) ) );
            s = WDserial();    % s = rotor( complement, b, n ); %slower alternative
            switch type
                case 1, flag = ( sum( bitxor( s(1:2:end-2 ), s(2:2:end-1) ) == s(3:2:end) ) == (j - 1) );
                case 2, flag = ( sum( bitand( s(1:2:end-2 ), s(2:2:end-1) ) == s(3:2:end) ) == (j - 1) );
                case 3, flag = ( sum( bitor( s(1:2:end-2 ), s(2:2:end-1) ) == s(3:2:end) ) == (j - 1) );
            end
            if flag
                s1(i) = Kappa; s2(i) = complement; disp(s)
            end
    end
end
plot(s1,'.'),hold on,plot( s2, '.r'),hold off
[cv1 cd1] = blockanalysis( s1>0 );
[cv2 cd2] = blockanalysis( s2>0 );
figure(2), bar(cd1)
figure(3), bar(cd2)
end