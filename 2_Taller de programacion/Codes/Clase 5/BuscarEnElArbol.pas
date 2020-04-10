Program	BusquedaDeArbol;
type

  arbol=^nodoA;
  nodoA=record
    dato:integer;
    izq:arbol;
    der:arbol;
  end;

function BuscarArbol(a:arbol;d:integer):arbol;
begin
	if(a<>nil)then begin
		if (a^.dato=d) then BuscarArbol:=a
		else 
			if(a^.dato<dato)then	BuscarArbol:=BuscarArbol(a^.der,d)
			else	BuscarArbol:=BuscarArbol(a^.izq,d);
	end;
	else
	BuscarArbol:=nil;
end;