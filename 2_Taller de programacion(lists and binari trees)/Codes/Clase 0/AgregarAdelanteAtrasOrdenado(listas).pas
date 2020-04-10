program Actividad_3;
type
    lista = ^nodo;
    nodo = record
      dato: integer;
      sig: lista;
    end;
procedure agregarAdelante(var l: lista; n:integer);
   var
     aux: lista;
   begin
     new(aux);
     aux^.dato := n;
     aux^.sig := l;
     l := aux;
   end;
   
procedure agregarAtras(var l, ult: lista; n:integer);
  var
    aux:lista;
  begin
    new(aux);
    aux^.dato := n;
    aux^.sig := nil;
    if (l = nil) then
      ult^.sig := aux
    else
      l := aux;
  ult:= aux;
  end;

procedure agregarOrdenado (var l:lista; n:integer);
  var ant, act, aux: lista;
begin
  new (aux);
  aux^.dato := n;
  act := l;
  while (act <> NIL) and (n > act^.dato) do begin
      ant := act;
      act := act^.sig;
  end;
  if (l = act) then
    aux^.sig:=l;
    l := aux;
  end
  else begin
    ant^.sig  := aux;
    aux^.sig := act;
  end;
end;

procedure imprimirLista(l:lista);
  var
    act: lista;
  begin
    act := l;
    while (act <> nil) do begin
      writeln('> ', act^.dato);
      act:= act^.sig;
    end;
end;

var
  aAd, aAt, ult, aO: lista;
  i,n:integer;
Begin
   randomize;
   aAd := Nil;
   aAt := Nil;
   aO  := Nil;

   //Generar listas
   for i:= 1 to 5 do begin
     n:= random(101);
     agregarAdelante(aAd, n);
     agregarAtras(aAt, ult, n);
     agregarOrdenado(aO, n);
   end;

   //Imprimir
   writeln('Agregar adelante');
   imprimirLista(aAd);
   writeln;
   writeln('Agregar atrás');
   imprimirLista(aAt);
   writeln;
   writeln('Agregar ordenado');
   imprimirLista(aO);

   readln;
End.