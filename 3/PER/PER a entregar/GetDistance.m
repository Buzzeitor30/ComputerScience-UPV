function[dist] = GetDistance(X,Y,p)
  if (p==2)
    dist = L2dist(X,Y);
  elseif (p==3)
    dist = L3Dist(X,Y);
  elseif (p==1)
    dist = L1dist(X,Y);
  else
    dist = L0dist(X,Y);
  endif
end
