function sat( fname, option, method )
% SAT: Main UI for data input and handling
% fname: File name for input
% option: (0) eval single expression or (1) all atom2literal states for Global Truth Table (GTT) of any SAT expression
% method: (0) for standard sateval function or (1) for the Sequential Dynamical System version (SATSDS). 
% For the last option, only a single negation code is evaluated due to memory restrictions.
clc, clf, hold off, close all;
if option > 1 || option < 0, error('Option values out of range!'), end
% Data reading
file = dlmread( ['xmpl.',fname,'.txt'] ); 
disp( [ num2str( size( file, 1) ),' lines read'] )
% Data preprocessing
clauses=[];atoms=[]; save = []; 
w = file > 0; mc = max( sum( w, 2 ) );% max. length for equalization (method = 1)
for i=1:size(file, 1)
    [c, v] = blockanalysis( w(i, :) ); 
    sgn = (abs( v(end)  ) > 1)*( v(end) < 0 ); % exclude meaningless zero blocks at the end     
    if sgn, newlen = sum( abs(v(1:end-1)) ); xtract = file(i, 1:newlen ); else xtract = file(i, :); end   
    save = [save, xtract]; 
    separate0 = xtract( xtract > 0 ); % separate atom ind?ces from negation marks
    clauses = [clauses, length(separate0)];
    atoms = [atoms, separate0];    
end
w = [save, zeros(1, length(save) )]; % extract zero marks for negations
w(2, find( save==0 ) + 1) = 1; 
w = w(:, find( w(1, :) > 0 )); 
negations = find( w(2, :) > 0 ); 
nc = length(clauses); % number of clauses
Lc = length( unique( clauses ) ); % number of unique clauses
L=sum(clauses); dim = 2^L; % expression length - total search space
nots = ones(1, L); nots( negations ) = -1; % make binary vector of weights for assignment map
if L~=length(atoms), error('SAT Main: Atom assignments do not match total expression length!'), end
if L~=length(nots), error('SAT Main: Number of negation operators does not match number of atom indices!'), end
if option, disp('Negation Code input ignored for 2nd arg = 1'), end
%%%%%%%%%%%%% Main %%%%%%%%%%%%%%%%%%%
[ocodes, no] = satassign( atoms, nots, Lc, L );
if method, 
    disp('No GTT available for 3rd arg = 1. 2nd arg ignored')   
    [c, d, cf, df] = satequalize( clauses, w(1, :), w(2, :), nc, mc, L ); clf, close all, graph(c, d, cf, df, L, 0), return;
end
int = 0:dim-1;
save = bin2dec( num2str( floor( (nots + 1)/2 ) ) ); %floor( (nots + 1)/2 )*(2.^(0:L-1))';
runlength = (dim - 2)*option + 1;
dnf = zeros( runlength+option, dim );cnf = dnf;    
csat = zeros(runlength+option); dsat = csat;
for nots = 1-option:runlength
    if runlength>1, save = nots; end
    [c d] = sateval( clauses, save, ocodes, int, dim - int - 1, nc, no ); 
    cnf(nots+option, :) = c; dnf(nots+option, :) = d; 
    csat(nots + option) = sum(c) > 0 ; dsat(nots+option) = sum( d ) > 0;
end
graph( cnf, dnf, sum( csat ), sum( dsat ), L, option );
end

function graph(c, d, cf, df, n, opt)
if cf==0, disp('CNF expression unsatisfiable!'), end
if df==0, disp('DNF expression unsatisfiable!'), end
if opt
    figure(1), imagesc( c ), title([ 'CNF GTT over [0,..., 2^', num2str(n),' ]' ]),colormap gray
    figure(2), imagesc( d ), title([ 'DNF GTT over [0,..., 2^', num2str(n),' ]' ]), colormap gray
else
     [u1 v1] = blockanalysis( c ); [u2 v2] = blockanalysis( d );
     figure(1), bar( v1 ), title([ 'CNF Block Analysis over [0,..., 2^', num2str(n),' ]' ])
     figure(2), bar( v2 ), title([ 'DNF Block Analysis [0,..., 2^', num2str(n),' ]' ])  
end
end
