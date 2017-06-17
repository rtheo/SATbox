function [overlaps, Lo] = satassign( atoms, nots, L, La, Lc )
  % connectivity matrix for assignment map
c = zeros(La, L); idx = [atoms; 1:L];
if isempty( nots ), nots = ones(1, L); end
for i=1:L, c( idx(1, i), idx(2, i) ) = nots(i);end
degeneracies = find( sum( abs(c), 2 ) > 1 ); 
if  ~isempty(degeneracies) 
    overlaps = find( sum( abs(c( degeneracies, : )), 1 ) == 1); 
else
    overlaps = [];
end
Lo = length(overlaps);
satclass = ( Lc > 1) + 2*( ~isempty(degeneracies));
figure(1), imagesc(c)
test = ones(1, L);
if floor( bin2dec( num2str( test( overlaps ) ) )/(dim-1) )
    ylabel 'Atoms', xlabel Literals: 'Unsatisfiable problem! (Overlap filters out all significance levels)')
else
    ylabel 'Atoms', xlabel 'Literals'
end
title(['ASSIGNMENT: SAT Class = ', num2str( satclass ),' Atoms: ',num2str(La),' Overlaps: ',num2str( Lo ), ' (PRESS ENTER)'])
pause
clc, clf, close all
end