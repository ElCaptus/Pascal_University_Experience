Program encomiendas;
const
    dimF=9;//dimension fisica del Vector por el peso del random
Type
    encomienda = record
        codigo: integer;
        peso: integer;
    end;

// Lista de encomiendas
    lista = ^nodoL;
    nodoL = record
        dato: encomienda;
        sig: lista;
    end;


{-----------------------------------------------------------------------------
AgregarAdelante - Agrega una encomienda adelante en l}
procedure agregarAdelante(var l: Lista; enc: encomienda);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := enc;
  aux^.sig := l;
  l:= aux;
end;


{-----------------------------------------------------------------------------
CREARLISTA - Genera una lista con datos de las encomiendas }
procedure crearLista(var l: Lista);
var
    e: encomienda;
    i: integer;
begin
    l:= nil;
    for i:= 1 to 20 do begin
        e.codigo := i;
        e.peso:= random (dimF+1);
        while (e.peso = 0) do 
            e.peso:= random (dimF+1);
        agregarAdelante(L, e);
    end;
end;


{-----------------------------------------------------------------------------
IMPRIMIRLISTA - Muestra en pantalla la lista l }
procedure imprimirLista(l: Lista);
begin
    While (l <> nil) do begin
        if (l^.dato.codigo<10) then
            writeln('Codigo: ', l^.dato.codigo, '   Peso: ', l^.dato.peso)
        else
            writeln('Codigo: ', l^.dato.codigo, '  Peso: ', l^.dato.peso);
        l:= l^.sig;
    end;
end;



procedure agregarOrdenado (var l:lista; d:encomienda);
var 
    ant, act, aux: lista;
begin
  new (aux);
  aux^.dato := d;
  act := l;
  while (act <> NIL) and (d.peso> act^.dato.peso) do begin
      ant := act;
      act := act^.sig;
  end;
  if (l = act) then begin
    aux^.sig:=l;
    l:=aux;
  end;
  else begin
    ant^.sig  := aux;
    aux^.sig := act;
  end;
end;


procedure PorPeso(l:Lista;var l2:Lista);
begin
    while (l<>nil) do begin
        agregarOrdenado(l2,l^.dato)
        l:=l^.sig;
    end;
end;


Var
    l,l2: lista;
begin
    Randomize;
    l2:=nil;
    crearLista(l);
    writeln ('Lista de encomiendas generada: ');
    imprimirLista(l);
    PorPeso(l,l2);
    imprimirLista(l2);
    readln;
end.