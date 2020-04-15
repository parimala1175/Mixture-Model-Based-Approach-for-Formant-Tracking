%THis function gives out AM and FM components for the signal and center
%frequency 
% gives out two vectors
function [AMcom, FMcom] = DESA(sig,wo)

slen = length(sig);
y = sig(2:slen) - sig(1:slen-1);   % difference signal
Lsig  = length(sig);
%% Teager Operator 
Yx = sig(2:Lsig-1).^2 - sig(1:Lsig-2).*sig(3:Lsig);
Lsig2  = length(y);
%% second order differnecing of signals
Yy = y(2:Lsig2-1).^2 - y(1:Lsig2-2).*y(3:Lsig2);
yz=y(2:length(y));
Lsig3=length(yz);
Yz = yz(2:Lsig3-1).^2 - yz(1:Lsig3-2).*yz(3:Lsig3);
L = length(Yz);
Yx = Yx(2:L+1);
Yy = Yy(1:L);

% perform DESA Algorithm
FMcom = zeros(1,L);
AMcom = zeros(1,L);

G = 1-(Yy+Yz)./(4*Yx);

in1 = find(abs(G)>=1);
G(in1) = cos(wo)*ones(length(in1),1);
%% This FMcom and AMcom can be found by the expressions mentioned desa
%% algorithm
FMcom = acos(G)';

in = find(Yx>=0);
AMcom(in) = sqrt(Yx(in)./(1-G(in).^2))';

% perform smoothing using Median filter
FMcom = medfilt(FMcom,5);
AMcom = medfilt(AMcom,5);

end
