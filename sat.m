function sat( fname, option )
clc, clf, hold off, close all;
if option > 1 || option < 0, error('Option values out of range!'), end
% Data reading
fid = fopen(['xmpl.',fname,'.txt'],'r');
k = 0;
while 1
    k = k + 1;
    tline = fgetl(fid);
    switch k
        case 2, clauses    = str2num(tline);
        case 4, atoms      = str2num(tline);
        case 6, negations = str2num(tline);
        case 7, if strcmp(tline,'EOF'), break, end 
    end
end
fclose(fid);
% Data preprocessing
nc = length(clauses); % number of clauses
L=sum(clauses); dim = 2^L; % expression length - total search space
La = length( unique(atoms) ); % number of unique atoms
Lc = length( unique( clauses ) ); % unique clause lengths
nots = ones(1, L); nots( negations ) = -1; % make binary vector of weights for assignment map
if L~=length(atoms)
    error('SAT Main: Atom assignments do not match total expression length!')
end
if L~=length(nots)
    error('SAT Main: Number of negation operators does not match number of atom indices!')
end
[overlaps, Lo] = satassign( atoms, nots, L, La, nc );
clf, close all
int = 0:dim-1;cs = [0, cumsum( clauses )];
cp = 2.^[0, cs ]; cc = 2.^clauses;
if option
    disp('Negation Code input ignored for option = 1')
    dnf = zeros( dim );cnf = dnf;     
    for nots = 0:dim-1
        [c d] = sateval( nots, overlaps, int, cp, cc, nc, Lo );
        cnf(nots+1, :) = c; dnf(nots+1, :) = d; 
    end
    graph( cnf, dnf, L, 1 );
else
    nots = floor( (nots + 1)/2 )*(2.^(0:L-1))';
    [c, d] = sateval( nots, overlaps, int, cp, cc, nc, Lo ); graph( c, d, L, 0 ); 
end
end

function graph(c, d, n, opt)
if opt
    figure(1), imagesc( c ), title([ 'CNF GTT over [0,..., 2^', num2str(n),' ]' ]),colormap gray
    figure(2), imagesc( d ), title([ 'DNF GTT over [0,..., 2^', num2str(n),' ]' ]), colormap gray
else
     [u1 v1] = blockanalysis( c ); [u2 v2] = blockanalysis( d );
     figure(1), bar( v1 ), title([ 'CNF Block Analysis over [0,..., 2^', num2str(n),' ]' ])
     figure(2), bar( v2 ), title([ 'DNF Block Analysis [0,..., 2^', num2str(n),' ]' ])  
end
end
