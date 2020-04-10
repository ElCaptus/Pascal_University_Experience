procedure insertar(var a:arbol; d:integer);
begin
	if (a=nil)then begin
		new(a);
		a^.dato:=d;
		a^.der:=nil;
		a^.izq:=nil;
		end
	else 
		if(d>a^.dato) then insertar(a^.der,d)
		else insertar(a^.izq,d);
end;