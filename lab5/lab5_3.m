tp = imread('smpte.png');
tpn = imnoise(tp, 'gaussian', 0,0.1);
%imshowpair(tp,tpn,'montage')
[m, n] = size(tpn);
tpnc = zeros(m,n);
z = zeros(m+2,n+2);
z(2:m+1,2:n+1) = tpn;
h=ones(3)/3^2
for k = 2:m+1
    for i = 2:n+1
        a = z(k-1:k+1,i-1:i+1);
        b = a .* h;
        c = sum(sum(b));
        tpnc(k-1,i-1) = c;
    end
end
%imshowpair(tpn,tpnc,'montage');
d = imnoise(tp,'salt & pepper',0.02);
z = function5_1_2('smpte.png');
figure(1);
imshowpair(d,z,'montage')
figure(2);
m = function5_1_3('smpte.png');
imshowpair(d,m,'montage')
figure(3);
imshowpair(z,m,'montage')