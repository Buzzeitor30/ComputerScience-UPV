#!/usr/bin/octave -qf
if (nargin!=6)
printf("Usage: gaussianexpp.m <trdata> <trlabels> <alphas> <%%trper> <%%dvper> <ks>\n");
exit(1);
end;

arg_list=argv();
#Matriz de datos de entrenamiento
trdata=arg_list{1};
#Clases 
trlabs=arg_list{2};
#Alpha
alphas=str2num(arg_list{3});
#Porcentaje de datos a entrenamiento
trper=str2num(arg_list{4});
#Porcentaje de datos dedicados a prueba
dvper=str2num(arg_list{5});
ks=str2num(arg_list{6});
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

[m,W] = pca(Xtr);


for a=alphas
    err=[];
    for k=ks
        proyX=(Xtr-m)*W(:,1:k);
        proyY=(Xdv-m)*W(:,1:k);
        aux = gaussian(proyX,xltr,proyY,xldv,a);
        err=[err;k,aux];
    endfor
    err
    printf("----------------------------------------\n");
endfor
