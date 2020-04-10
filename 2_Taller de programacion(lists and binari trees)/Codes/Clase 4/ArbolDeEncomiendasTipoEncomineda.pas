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

  arbol=^nodoA;
  nodoA=record
    dato:encomienda;
    izq:arbol;
    der:arbol;
  end;


procedure insertar(var a:arbol; d:encomienda);
var
  aux:arbol;
begin
  if (a=nil)then begin
    new(aux);
    aux^.dato:=d;
    aux^.der:=nil;
    aux^.izq:=nil;
    a:=aux;
    end
  else 
    if(d.peso>a^.dato.peso) then insertar(a^.der,d)
    else insertar(a^.izq,d);
end;

procedure imprimirArbol(a:arbol);
begin
  if(a<>nil)then begin
    imprimirArbol(a^.izq);            
    writeln('Codigo: ', a^.dato.codigo, '   Peso: ', a^.dato.peso);
    imprimirArbol(a^.der);
  end;
end;

procedure recorrerLista(l:lista;var a:arbol);
begin
  while (l<>nil)do begin
    insertar(a,l^.dato);
    l:=l^.sig;
  end;
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





Var
    a:arbol;
    l: lista;
begin
    Randomize;
    a:=nil;
    crearLista(l);
    writeln ('Lista de encomiendas generada: ');
    imprimirLista(l);
    recorrerLista(l,a);
    writeln('Arbol de encomiendas ordenada por peso: ');
    imprimirArbol(a);
    readln;
end.