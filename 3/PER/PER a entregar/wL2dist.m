%Simplemente aplicamos la fórmula
function D = wL2dist (X,Y,W)
for i =1:rows(X)
  D(i,:) = sum(1./W*abs(X-Y(i,:)).^2,2);
end
endfunction

%¿Versión rápida? No estoy seguro de si funciona
%Pero lo dejo comentada y si me puedes dar tu
%opinión mejor
% function D = wL2dist(X,Y,W)
%   XX = sum(X.^2,2);
%   YY = sum(Y.^2,2);
%   D = 1./W*(XX+ (YY'-2*X*Y);
% endfunction
