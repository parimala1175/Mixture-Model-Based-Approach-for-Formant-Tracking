function rs = medfilt(s, p)


s = s(:)';
L = length(s);
rs = zeros(size(s));

ad = (p-1)/2;

if ad == 0
    rs = s;
    return;
end

s = [s(1)*ones(1,ad) s s(L)*ones(1,ad)];
w = 1:p;

A = fliplr(toeplitz(fliplr(s(1:L)),s(L:L+p-1))');
rs = median(A);


