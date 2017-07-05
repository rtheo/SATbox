function sat( fname, option, method )
% SAT: Main UI for data input and handling
% fname: File name for input
% option: (0) eval single expression or (1) all atom2literal states for Global Truth Table (GTT) of any SAT expression
% method: (0) for standard sateval function or (1) for the Sequential Dynamical System version (SATSDS). 
% For the last option, only a single negation code is evaluated due to memory restrictions.
clc, clf, hold off, close all;
if option > 1 || option < 0, error('Option values out of range!'), end
file = dlmread( ['xmpl.',fname,'.txt'] ); 
%%%%%%%%%%% Preprocessing %%%%%%%%%%%%%%%%%
disp( [ num2str( size( file, 1) ),' lines read'] )
clauses = sum( abs( file ) > 0, 2 )';
w = file'; atoms = w( abs(w) > 0 )'; 
nots = atoms < 0; atoms = abs( atoms );
Lc = length( unique( atoms ) ); % number of unique alauses  
L=sum(clauses); % expression length 
if L~=length(atoms), error('SAT Main: Atom assignments do not match total expression length!'), end
if L~=length(nots), error('SAT Main: Number of negation operators does not match number of atom indices!'), end
if option, disp('Negation Code input ignored for 2nd arg = 1'), end
ocodes = satassign( atoms, 1-2*nots, Lc, L );
%%%%%%%%%%%%% SDSS Method %%%%%%%%%%%%%%%%
%(Under construction - not active yet)
if method, 
    disp('No GTT available for 3rd arg = 1. 2nd arg ignored')   
    [c, d] = satequalize( clauses, w(1, :), w(2, :), max(clauses), L ); 
    clf, close all, graph(c, d, L, 0), return;
end
%%%%%%%%% Indicator Method %%%%%%%%%%%%%%%%%%%
%disp(clauses), disp(nots), disp(ocodes), pause
[cnf, dnf] = sateval( clauses, nots, ocodes, 2^L, option );
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
