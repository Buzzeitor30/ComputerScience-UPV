#!/usr/bin/octave -qf

if (nargin!=5)
printf("Usage: multinomial-eva.m <trdata> <trlabels> <tedata> <telabels> <eps>\n")
exit(1);
end;

arg_list=argv();
trdata=arg_list{1};
trlabs=arg_list{2};
tedata=arg_list{3};
telabs=arg_list{4};
eps=str2num(arg_list{5});
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
err_original = multinomial(X,xl,Y,yl,eps);
printf("%d\n",err_original);

