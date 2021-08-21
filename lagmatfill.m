function yfill = lagmatfill(y,q,m1,m2)
% Code for filling lagmatrix with past means by preserving length of original vector series y.
% Guido Travaglini, December 1/11
% Function is yfill = lagmatfill(y,lags,m1,m2)
%
% INPUTS:
% y: original series of size T x 1
% q: lags in lagmatrix =>1
% m1, m2: initial observations of y wherefrom compute mean, m2>m1=>2
%
% OUTPUT:
% yfill: filled-in lagmatrix of size T x q
%
T=length(y); yfill=[y,zeros(T,q)];
for j=1:q
ylak=lagmatrix(yfill(:,j),1);yfill(1,j+1)=mean(yfill(m1:m2,j));
yfill(2:end,j+1)=ylak(2:end,:);
end
yfill=yfill(:,2:end);
%
end