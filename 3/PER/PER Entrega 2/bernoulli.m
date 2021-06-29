 function edv = bernoulli(Xtr,xltr,Xdv,xldv,umbral,epsilon)
   %Con esto los datos están binarizados
    Xtr = Xtr > floor(255*umbral);
    Xdv = Xdv > floor(255*umbral);
    %Prob. priori y posteriori
    priori=[];
    posteriori=[];
    %Donde almacenamos el error
    edv = [];
    %Sacamos las clases
    clases = unique(xltr);
    for c = clases'
        %Numero de elementos de la clase
        filas = find(xltr==c);
        %Probabilidad a priori
        priori(c+1,:) = rows(filas)/rows(xltr);
        %Prob a posteriori
        posteriori(c+1,:) = 1/rows(filas)*sum(Xtr(filas,:));
    endfor
    
    %Vamos a aplicar todos los valores de epsilon
    for e=epsilon
      %Probabilidad a posteriori después de aplicar
      %suavizado
      aux = truncSimp(posteriori,e);
      %Valor de wc
      wc = log(aux) - log(1-aux);
      %Valor de wc0
      wc0 = log(priori) + sum(log(1-aux),2);
      %Sacamos los índices correspondientes
      [~,idx] = max(Xdv*wc'+wc0',[],2);
      %Restamos 1 del que hemos añadido antes...
      idx = idx - 1;
      %Sacamos el error medio
      err= mean(idx != xldv) * 100;
      %Guardamos el resultado
      edv=[edv;e,err];
    endfor
 endfunction

 %Esta función realiza el suavizado de truncamiento
 %simple
 function res = truncSimp(X,epsilon)
   res=X;
   %Menor que epsilon
   aux = find(X<epsilon);
   %Actualizamos a epsilon
   res(aux) = epsilon;
   %Mayo que 1 -epsilon;
   aux = find(X> 1-epsilon);
   %Actualizamos valores
   res(aux) = 1 - epsilon;
 endfunction
