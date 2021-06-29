function [edv] = multinomial (Xtr, xltr, Xdv, xldv, epsilons)
  output_precision(2);
  %Sacamos todas las clases que hay
  clases = unique(xltr)';
  %Recorremos cada clase
  for c=clases
    %Prototipos que pertenecen  a la clase
    filas = find(xltr == c);
    %Actualizamos la probabilidad p(c)
    priori(c + 1,:) = rows(filas)/rows(xltr);
    %Sacamos el sumatorio de los vectores que pertencen a la clase
    aux = sum(Xtr(filas,:));
    %La constante
    aux2 = sum(sum(Xtr(filas,:),2));
    %Parametros de bermoulli para cada clase
    parametros(c + 1,:) = (1/aux2) * aux;
  endfor
  i = 1;
  for e=epsilons
   %Le sumamos a cada componente de cada
   %vector un valor de epsilon
   aux = parametros + e;
   %Normalizamos
   aux = aux ./ sum(aux);
   %Sacamos el maximo y sus indices
   [c,I] = max(log(aux)*Xdv' + log(priori));
   %Sacamos el error medio
   err = mean(I' - 1  != xldv);
   %Imprimimos el error medio
   edv(i,:) = [e,err*100];
   i += 1;
  endfor
  edv
endfunction
