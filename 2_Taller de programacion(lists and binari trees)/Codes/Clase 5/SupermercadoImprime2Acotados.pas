program Ejercitacion1Arboles;
uses 
	sysutils;
type
	cadena=string[100];
	producto=record
		tipo:cadena;
		descripcion:cadena;
		codigo:integer;
		precio:real;
	end;

	arbol=^nodoA;
	nodoA=record
		dato:producto;
		izq:arbol;
		der:arbol;
	end;

procedure insertar(var a:arbol; d:producto);
begin
	if (a=nil)then begin
		new(a);
		a^.dato:=d;
		a^.der:=nil;
		a^.izq:=nil;
		end
	else 
		if(d.codigo>a^.dato.codigo) then insertar(a^.der,d)
		else insertar(a^.izq,d);
end;

procedure leer(var d:producto);
begin
	write('Escriba un tipo de producto: ');
	readln(d.tipo);
	if(d.tipo<>'zzz')then begin
		d.codigo:=random(20);
		writeln('codigo: ',d.codigo);
		d.descripcion:=inttostr(random(500));
		write('Escriba un precio para el producto: ');
		d.precio:=random(300);
		writeln(d.precio);
	end;
end;

procedure crearArbol(var a:arbol);
var
	p:producto;
begin
	leer(p);
	while(p.tipo<>'zzz')do begin
		insertar(a,p);
		leer(p);
	end;
end;

procedure imprimirArbol(a:arbol);
begin
	if(a<>nil)then begin
		imprimirArbol(a^.izq);						
		writeln(a^.dato.tipo);
		imprimirArbol(a^.der);
	end;
end;

procedure recorridoAcotado(a:arbol;inf,sup:integer);
begin
	if(a<>nil)then begin
		if(a^.dato.codigo>=inf)then
			if(a^.dato.codigo<=sup)then begin
				recorridoAcotado(a^.izq,inf,sup);
				writeln(a^.dato.tipo);
				writeln(a^.dato.descripcion);
				recorridoAcotado(a^.der,inf,sup);
			end
			else
			recorridoAcotado(a^.izq,inf,sup)
		else
		recorridoAcotado(a^.der,inf,sup);
	end;
end;

procedure recorridoAcotado2(a:arbol;inf,sup:integer;var cont:integer);
begin
	if(a<>nil)then begin
		if(a^.dato.precio>=inf)then
			if(a^.dato.precio<=sup)then begin
				recorridoAcotado2(a^.izq,inf,sup,cont);
				cont:=cont+1;
				recorridoAcotado2(a^.der,inf,sup,cont);
			end
			else
			recorridoAcotado2(a^.izq,inf,sup,cont)
		else
		recorridoAcotado2(a^.der,inf,sup,cont);
	end;
end;

procedure imprimirAcotado(a:arbol);
var
	n1,n2:integer;
begin
	writeln('Escriba el rango de codigo que quiere saber tipo y descripcion: ');
	readln(n1);
	readln(n2);
	recorridoAcotado(a,n1,n2);
end;

procedure cantidadProductos(a:arbol);
var
 cont:integer;
begin
	cont:=0;
	write('La cantidad de productos cuyo precio esta entre 50 y 100 pesos es: ');
	recorridoAcotado2(a,50,100,cont);
	writeln(cont);
end;


var
	a:arbol;
begin
	randomize;
	a:=nil;
	crearArbol(a);
	imprimirArbol(a);
	imprimirAcotado(a);
	cantidadProductos(a);
	readln();
end.