#!/usr/bin/octave -qf

if (nargin!=6)
printf("Usage: pca+knn-eva.m <trdata> <trlabels> <tedata> <telabels> <k> <p>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
tedata=arg_list{3};
telabs=arg_list{4};
k=str2num(arg_list{5});
p=str2num(arg_list{6});
p
load(trdata);
load(trlabs);
load(tedata);
load(telabs);

%
% HERE YOUR CODE
%
%Hacemos una permutación
N=rows(X);
rand("seed",23); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);
#Sacamos media y matriz X
[m,W] = pca(X);
err_original = knn(X,xl,Y,yl,1,p);
printf("%d\n",err_original);
#Errores proyectando
proyX=(X-m)*W(:,1:k);
proyY=(Y-m)*W(:,1:k);
err_proy = knn(proyX,xl,proyY,yl,1,p);
printf("%d\n",err_proy);
