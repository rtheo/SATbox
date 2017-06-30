function ocodes = satassign( atoms, nots, Lc, L )
% Find connectivity matrix for assignment map
La = length( unique( atoms ) ); % number of unique atoms  
c = zeros(La, L); idx = [atoms; 1:L]; 
if isempty( nots ), nots = ones(1, L); end
for i=1:L, c( idx(1, i), idx(2, i) ) = nots(i);end, disp(c)
degeneracies = find( sum( abs(c), 2 ) > 1 ); 
deglen = length(degeneracies);
maxdeg = max( sum(c, 2) );
base = 2.^(0:L-1);
if  isempty(degeneracies), ocodes = [];Lo = 0; end
ocodes = zeros( 1, deglen );
for i=1:deglen    
    pick = abs( c( degeneracies(i), :) ); 
    Deg = sum( abs( pick ) );
    ocodes(i) = sum( pick.*base );
end
satclass = ( Lc > 1) + 2*( ~isempty(degeneracies));
figure(1), imagesc(c)
ylabel 'Atoms', xlabel 'Literals'
title(['ASSIGNMENT: SAT Class = ', num2str( satclass ),', Atoms: ',num2str(La),', Overlaping: ',num2str( length(ocodes) ), ' (PRESS ENTER)'])
pause
clc, clf, close all
end