function [overlaps, Lo] = satassign( atoms, nots, L, La, Lc )
  % connectivity matrix for assignment map
c = zeros(La, L); idx = [atoms; 1:L];
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
ylabel 'Atoms', xlabel 'Literals'
title(['ASSIGNMENT: SAT Class = ', num2str( satclass ),' Atoms: ',num2str(La),' Overlaps: ',num2str( Lo ), ' (PRESS ENTER)'])
pause
clc, clf, close all
end