function sat( fname, option, method )
% SAT: Main UI for data input and handling
% fname: File name for input
% option: (0) eval single expression or (1) all atom2literal states for Global Truth Table (GTT) of any SAT expression
% method: (0) for standard sateval funciton or (1) for the Sequential Dynamical System version (SATSDS). 
% For the last option, only a single negation code is evaluated due to memory restrictions.
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
if L~=length(atoms), error('SAT Main: Atom assignments do not match total expression length!'), end
if L~=length(nots), error('SAT Main: Number of negation operators does not match number of atom indices!'), end
if option, disp('Negation Code input ignored for 2nd arg = 1'), end
%%%%%%%%%%%%% Main %%%%%%%%%%%%%%%%%%%
[ocodes, Lo] = satassign( atoms, nots, L, La, nc );
if method, 
    disp('No GTT available for 3rd arg = 1. 2nd arg ignored')
    [c, d] = satequalize(clauses, negations, overlaps, nc, Lo, dim ); 
    clf, close all, graph(c, d, L, opt), return;
end
int = 0:dim-1;
save = bin2dec( num2str( floor( (nots + 1)/2 ) ) ); %floor( (nots + 1)/2 )*(2.^(0:L-1))';
runlength = (dim - 2)*option + 1;
dnf = zeros( runlength+option, dim );cnf = dnf;    
for nots = 1-option:runlength
    if runlength>1, save = nots; end
    [c d] = sateval( clauses, save, ocodes, int, dim - int - 1, nc, Lo ); 
    cnf(nots+option, :) = c; dnf(nots+option, :) = d; 
end
graph( cnf, dnf, L, option );
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