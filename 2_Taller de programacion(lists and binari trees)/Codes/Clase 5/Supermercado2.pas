program Supermercado2;
uses
	sysutils;
type
	f=record
		dia:1..31;
		mes:1..12;
		anio:integer;
	end;
	cadena=string[20];

	producto=record
		fecha:f;
		codigo:integer;
		tipo:cadena;
		cantidad:integer;
		montoTotal:real;
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
	d.cantidad:=random(9)-1;
	writeln('cantidad: ',d.cantidad);
	if(d.cantidad<>-1)then begin
		write('Escriba un tipo de producto: ');
		d.tipo:=inttostr(random(9));
		d.codigo:=random(1000)+1400;
		writeln('~~codigo: ',d.codigo);
		write('Escriba el montoTotal que pago por el producto: ');
		d.montoTotal:=random(500);
		writeln(d.montoTotal);
	end;
end;

procedure crearArbol(var a:arbol);
var
	p:producto;
begin
	leer(p);
	while(p.cantidad<>-1)do begin
		insertar(a,p);
		leer(p);
	end;
end;

procedure imprimirAcotado(a:arbol;inf,sup:integer);
begin
	if(a<>nil)then begin
		if(a^.dato.codigo>=inf)then
			if(a^.dato.codigo<=sup)then begin
				imprimirAcotado(a^.izq,inf,sup);
				writeln(a^.dato.tipo);
				imprimirAcotado(a^.der,inf,sup);
			end
			else
			imprimirAcotado(a^.izq,inf,sup)
		else
		imprimirAcotado(a^.der,inf,sup);
	end;
end;

procedure recorrerArbol(a:arbol;var c:integer);
begin
	if(a<>nil) then begin
		if(a^.dato.montoTotal>100)then
			contador:=contador+1;
		recorrerArbol(a^.izq,c);
		recorrerArbol(a^.der,c)
	end;
end;

procedure recorrerArbolEImprimirVentas(a:arbol);
var
	contador:integer;
begin
	contador:=0;
	recorrerArbol(a,contador);
	writeln('La cantidad de ventas cuyo monto supero los 100 pesos fue de: ',contador);
end;

var
	a:arbol;
begin
	randomize;
	a:=nil;
	crearArbol(a);
	imprimirAcotado(a,1500,2200);
	recorrerArbolEImprimirVentas(a);
	readln();
end.