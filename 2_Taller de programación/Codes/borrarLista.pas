program programaArboles;
type
	arbol=^nodoA;
	nodoA=record
		dato:integer;
		izq:arbol;
		der:arbol;
	end;
procedure BuscarMaximo(a:arbol;var aux:arbol);
begin
	if(a<>nil)then begin
		if(a^.der=nil)then
			aux:=a
		else
			Buscarmaximo(a^.der,aux);
	end;
end;
procedure buscarMinimo(a:arbol;var aux:arbol);
begin
	if(a<>nil)then
		if(a^.izq=nil)then
			aux:=a
		else
			buscarMinimo(a^.izq,aux);
end;

procedure borrarElemento(a:arbol;d:integer;var aux:arbol); //aux inicializar en nil
begin
	if(a<>nil)then begin
		if(a^.dato>d)then
			borrarElemento(a^.izq,d);
		else
			if(a^.dato<dato)then
				borrarElemento(a^.der,d);
			else
				if(a^.izq=nil)and(a^.der<>nil)then begin
					BuscarMinimo(a^.der,aux);
					a^.dato:=aux^.dato;
					BuscarElemento(a^.der,aux^.dato,aux);
				end	
				else
					if(a^.izq<>nil)and(a^.der=nil)then begin
						BuscarMaximo(a^.izq,aux);
						a^.dato:=aux^.dato;
						borrarElemento(a^.izq,aux^.dato,aux);
					end
					else 
						if(a^.izq=nil)and(a^.der=nil) then begin
							dispose(a);
							a:=nil;
						end
						else begin
							Buscarmaximo(a^.der,aux);
							a^.dato:=aux^.dato;
							borrarElemento(a^.der,aux^.dato,aux);
						end;
	end;
end;
{borrarElemento (árbol, dato, resultado)
  si árbol es vacío no se encontró el dato a borrar
  sino
    si el dato en árbol es > dato
      borrarElemento (hijo_izq_del_árbol, dato, resultado);
    sino
      si el dato en árbol es < dato
        borrarElemento (hijo_der_del_árbol, dato, resultado);
      sino 
       //se encontró el dato a borrar
        si tiene sólo hijo derecho …
        sino 
          si tiene sólo hijo izquierdo …
          sino 
             buscar el mínimo del subárbol derecho 
             reemplazar el valor en árbol por el mínimo
             borrarElemento (hijo_der_del_árbol,mínimo,resultado);
}