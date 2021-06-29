#!/usr/bin/octave -qf
if (nargin!=6)
    printf("Usage: gaussian.m <trdata> <trlabels> <tedata> <telabels> <alphas> <ks>\n")
    exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
tedata=arg_list{3};
telabs=arg_list{4};
alphas=str2num(arg_list{5});
k = str2num(arg_list{6});
load(trdata);
load(trlabs);
load(tedata);
load(telabs);

N=rows(X);
rand("seed",23); permutation=randperm(N);
X=X(permutation,:); xl=xl(permutation,:);
[m,W] = pca(X);
proyX=(X-m)*W(:,1:k);
proyY=(Y-m)*W(:,1:k);
err_original = gaussian(proyX,xl,proyY,yl,alphas);
printf("%d\n",err_original);


