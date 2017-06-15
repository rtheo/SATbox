function e = eta(x, y, z, v)
if nargin<4, v = 0; end
if v < 0 || v > 1, error('3rd arg should be Boolean!'), end
e = (y - mod(x, y + z)>0);
if v, e = 1 - e; end
end