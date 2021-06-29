## Copyright (C) 2021 Elias
## Author: Elias <elias@elias-ms7b86>
## Created: 2021-03-23

function [m,W]= pca (X)
  filenames = ["photo1.jpg";"photo2.jpg";"photo3.jpg";"photo4.jpg";"photo5.jpg"];
  %Sacamos la media
  m = mean(X);
  %Normalizamos X
  Xm = X - m;
  %Matriz de covarianza
  covarianza =(Xm'*Xm)/rows(Xm);
  %Valores y vectores propios
  [eigvec,eigval] = eig(covarianza);
  #Sacamos la diagonal de la matriz de covarianza 
  #y ordenamos los datos de forma descendente
  [S,I] = sort(diag(eigval),"descend");
  #Matriz W
  W = eigvec(:,I);
  %Esto es para ver los dígitos y guardar los ficheros para ponerlos en la práctica
  for i=1:5
    xr = reshape(W(:,i),28,28);
    h = imshow((255-xr)',[]);
    saveas(h,filenames(i,:));
    pause(1);
  endfor
endfunction
