function [save, k] = ipart(n)
% IPART : INTEGER PARTITIONS FROM ORDERED DICTIONARIES 
% (Fast, small numbers version)
% Given a powerset of integers of binary log = n it extracts all partitions
% from the binary dictionary of the associated bit strings. Use prime list
% to make a repetition avoidance filter.
% -----------------------------------------------------
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flag = 0; sflag = 0; s = [];
plist = primes(  2^(2*n+1) );
save = []; mem = [0]; k = 0;
for i=1:2^(2*n-1)
   [s, sflag] = serialWD( s, 2*n-1, sflag );     
   [cdim, cv] = blockanalysis( s );
   cv = abs(cv) - 1; idx = prod(plist( cv+1 ));
   flag = sum( idx*ones(1,length(mem)) == mem ) == 0;
   if cdim == n && flag, 
       mem = [mem, idx]; 
       save = [save; sort(  cv  , 'descend' ) ];
       k = k + 1;
   end   
end
end