function W = MatrizW(X,xl,alpha)
  %Sacamos las clases de los prototipos
  clases = unique(xl);
  %W tiene el mismo tamaño que X
  W = zero(rows(X),columns(X));
  %Recorremos todas las clases
  for c=clases:
    %Filas que cumplen la condición
    filas = find(xl == c)
    %Calculamos la varianza de aquellas que cumplen la condición
    X2 = var(X(filas,:),1);
    %Calculamos la varianza suavizada
    varsuav = alpha * X2 + (1-alpha)*ones(size(X2));
    %Introducimos en las filas de W correspondientes
    W(filas,:) += varsuav
  endfor
  endfunction
