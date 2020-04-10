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

    listaCodigos=^nodoCodigos;
    nodoCodigos=record
      dato:integer;
      sig:listaCodigos;
    end;

    arbol=^nodoA;
    nodoA=record
      peso:integer;
      codigos:listaCodigos;
      izq:arbol;
      der:arbol;
    end;

procedure agregarAdelanteA(var l: listaCodigos; d: integer);
var
  aux: listaCodigos;
begin
  new(aux);
  aux^.dato := d;
  aux^.sig := l;
  l:= aux;
end;

procedure insertar(var a:arbol; d:encomienda);
begin
  if (a=nil)then begin
    new(a);
    a^.peso:=d.peso;
    a^.codigos:=nil;
    agregarAdelanteA(a^.codigos,d.codigo);
    a^.der:=nil;
    a^.izq:=nil;
    end
  else 
    if(d.peso>a^.peso) then insertar(a^.der,d)
    else 
      if(d.peso<a^.peso) then insertar(a^.izq,d)
      else begin
        agregarAdelanteA(a^.codigos,d.codigo)
      end;
end;

procedure imprimirArbol(a:arbol);
var
  l:listaCodigos;
begin
  if(a<>nil)then begin
    imprimirArbol(a^.izq); 
    l:=a^.codigos;           
    write('Peso: ',a^.peso,'     Codigo:  ');
    while(l<>nil)do begin
      write(l^.dato,', ');
      l:=l^.sig;
    end;
    writeln('.');
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