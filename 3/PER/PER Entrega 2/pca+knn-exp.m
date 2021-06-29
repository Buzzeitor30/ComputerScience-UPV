#!/usr/bin/octave -qf

if (nargin!=6)
printf("Usage: pca+knn-exp.m <trdata> <trlabels> <ks> <%%trper> <%%dvper> <p>\n")
exit(1);
end;

arg_list=argv();
#Matriz de datos de entrenamiento
trdata=arg_list{1};
#Clases 
trlabs=arg_list{2};
#Dimensiones a proyectar
ks=str2num(arg_list{3});
#Porcentaje de datos a entrenamiento
trper=str2num(arg_list{4});
#Porcentaje de datos dedicados a prueba
dvper=str2num(arg_list{5});
p=str2num(arg_list{6});

#Cargamos matrices
load(trdata);
load(trlabs);

N=rows(X);
rand("seed",23); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);
#Pillamos porcentajes
Ntr=round(trper/100*N);
Ndv=round(dvper/100*N);
#Matriz de datos
Xtr=X(1:Ntr,:); xltr=xl(1:Ntr);
#Matriz de entrenamiento
Xdv=X(N-Ndv+1:N,:); xldv=xl(N-Ndv+1:N);

%
% HERE YOUR CODE
% 
#Sacamos la media y la matriz W
[m,W] = pca(Xtr);
#Matriz de datos y prueba
Xtrm = Xtr - m;
Xdvm = Xdv - m;
#Error sin proyectar
err = knn(Xtrm,xltr,Xdvm,xldv,1,p);
printf("Original 1-NN err = %f\n", err);
errores = [];
for k=ks
    Wp=W(:,1:k);
    proyXtr = Xtrm*Wp;
    proyXdv = Xdvm*Wp;
    err = knn(proyXtr,xltr,proyXdv,xldv,1,p);
    errores = [errores;k,err];
    printf("1-NN PCA-k = %d err:%.2f\n",k,err);
endfor
errores
