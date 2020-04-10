program recorridoAcotadoArbol;
type
	arbol=^nodoA;
	nodoA=record
		dato:integer;
		izq:arbol;
		der:arbol;
	end;
{recorridoAcotado(arbol, inf, sup);

si arbol no está vacío
  si el valor en arbol es >= inf 
    si el valor en arbol es <= sup 
        mostrar valor
        recorridoAcotado (hijo_izq_arbol, inf, sup);   
        recorridoAcotado (hijo_der_arbol, inf, sup);
    sino
        recorridoAcotado (hijo_izq_arbol, inf, sup);
  sino
    recorridoAcotado (hijo_der_arbol, inf, sup);
}
procedure recorridoAcotado(a:arbol;inf,sup:integer);
begin
	if(a<>nil)then begin
		if(a^.dato>=inf)then
			if(a^.dato<=sup)then begin
				writeln(a^.dato);
				recorridoAcotado(a^.izq,inf,sup);
				recorridoAcotado(a^.der,inf,sup);
			end
			else
			recorridoAcotado(a^.izq,inf,sup)
		else
		recorridoAcotado(a^.der,inf,sup);
	end;
end;
