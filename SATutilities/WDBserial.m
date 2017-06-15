function [s, sflag] = WDBserial( s, n, sflag )
%serialWD: Sequential Binary Words Dictionary Consructor
% Produces the powerset of constant length N bit strings avoiding memory
% overflow. Use serialWD([], N, 0) to initialize   
% s:      bit string
% n:      max. binary logarithm
% sflag: initialization 
%-------------------------------------------------------------------------------------------------------
if isempty(s)
    %initialize zero vector
    s = zeros(1,n); return
end

% overflow check
if sum(s)==n, sflag = 1; return, end

old = s(1); s(1) = 1 - s(1);
if old
    pos = 2;
    while s(pos), s(pos-1) = 0; pos = pos + 1; end
    s(pos-1) = 0; s(pos) = 1;
end
end