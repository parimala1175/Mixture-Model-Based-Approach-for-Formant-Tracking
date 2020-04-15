%%% Gabor filter with a cutoff frequency as omega normalized using 
function [feven] = Gabor1d_i( r, sig, omega, show )
r = ceil(r);  n=2*r+1;
x = -r:r;
%% THis generates the filter coefficients
feven = -cos(2*pi*x*omega) .* exp(-(x.^2)/sig^2);
inds = abs(feven)>.00001;  feven(inds) = feven(inds) - mean(feven(inds));

feven = feven/norm(feven(:),1);

 
end
