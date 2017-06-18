function [overlaps, powers, Lo] = satassign( atoms, nots, L, La, Lc )
  % connectivity matrix for assignment map
c = zeros(La, L); idx = [atoms; 1:L];
if isempty( nots ), nots = ones(1, L); end
for i=1:L, c( idx(1, i), idx(2, i) ) = nots(i);end
degeneracies = find( sum( abs(c), 2 ) > 1 ); 
base = 2.^(0:L-1);powers = [];
for i=1:length(degeneracies)
    p = c( degeneracies(i), :).*base;
    powers = [powers, p( p > 0 )];
end
if  ~isempty(degeneracies) 
    overlaps = find( sum( abs(c( degeneracies, : )), 1 ) == 1); 
else
    overlaps = [];
end
Lo = length(overlaps);
satclass = ( Lc > 1) + 2*( ~isempty(degeneracies));
figure(1), imagesc(c)
ylabel 'Atoms', xlabel 'Literals'
title(['ASSIGNMENT: SAT Class = ', num2str( satclass ),' Atoms: ',num2str(La),' Overlaps: ',num2str( Lo ), ' (PRESS ENTER)'])
pause
clc, clf, close all
test = ones(1, L);
if floor( bin2dec( num2str( test( overlaps ) ) )/(2^L - 1) )
    ylabel 'Atoms', xlabel Literals: 'Unsatisfiable problem! (Overlaps filter out all significance levels)')
    yn = '0';
    while ~strcmp(yn, 'y')||~strcmp(yn,'n') 
        yn = input('Interrupt? (y/n)');
    end
end
end