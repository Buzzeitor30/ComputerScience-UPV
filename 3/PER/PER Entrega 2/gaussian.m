function [edv] = gaussian(Xtr,xltr,Xdv,xldv,alphas)
  %Sacamos las clases que hay del conjunto de datos
  clases = unique(xltr)';
  %Para cada clases
  for c = clases
      %Prototipos que pertenecen a la clases
      filas = find(xltr == c);
      %p(c) para c nueva
      priori(c+1,:) = rows(filas)/rows(xltr);
      %Matriz auxiliar que realiza el sumatorio de los
      %vectors que pertenecen a la clase
     mu(:,c+1) = sum(Xtr(filas,:)) * inv(rows(filas));
     %Variable auxiliar donde previamente multiplicamos
     aux = (Xtr(filas,:) - mu(:,c+1)')'*(Xtr(filas,:) - mu(:,c+1)');
      %Entrada en el el vector de celdas de covarianzas
      %Covarianza correspondiente a la clase c
      sigma{c+1} = inv(rows(filas)) * aux;
  endfor
  i = 1;
  for a = alphas
    for c = clases
      aux = a*sigma{c+1} + (1-a)*eye(rows(sigma{c+1}));
      pr(:,c+1) = gc(priori(c+1,:),mu(:,c+1),aux,Xdv);
    endfor
    [~,idx] = max(pr,[],2);
    idx = idx - 1;
    edv(i,:) = [a,mean(xldv != idx) * 100];
    i = i + 1;
  endfor
endfunction    
  
  %p(x,c)
  function [probabilidades] = gc(pc, media, sigma, Y)
    %Inversa de sigma
    sigmainv = pinv(sigma);
    %Calculamos Wc con la pseudoinversa,
    Wc = -1/2 * sigmainv;
    %calculamos wc 
    wc = sigmainv * media;
    %wc0, escalar
    wc0 = log(pc) - 0.5*logdet(sigma) - 0.5 * media' * sigmainv * media;
    prob1= sum((Y*Wc).*Y,2);
    prob2 =Y*wc;
    probabilidades = prob1 + prob2 +wc0;
  endfunction
  
  
  function [val] = logdet(sigma)
    %Valores propios
    eigval = eig(sigma);
    if(any(eigval <=0))
      val = log(realmin);
    else
      val = sum(log(eigval));
    endif  
  endfunction
