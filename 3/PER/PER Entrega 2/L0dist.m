 function D = L0dist(X,Y)
  for i=1:rows(Y)
    D(:,i) = max(abs(X-Y(i,:)),[],2);
 end
