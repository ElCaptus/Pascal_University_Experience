program VectorDeListas;
type
	rango=1980..2018;   //rango de ingreso
	tipo=1..4;                  
	cadena20= string[20];   
	
	empleado= record      
		apellido: cadena20;
		anoingreso: rango;
		categoria: tipo;
	end;

	lista=^ nodo;       //LISTA
	nodo = record
	  dato: empleado;
	  sig:lista;
	 end;
	Vector= array [1..4] of lista;
//----------------------------Procedimientos------------------------------------//
procedure leer (var d:empleado);
var
	n:integer;
	a:cadena20;
begin
	writeln('Escribe el apellido: ');
	readln(a);
	d.apellido:=a;
	n:= random(39)+1980; // Random de 1980 a 2018 
	d.anoingreso:=n;
	n:= random(4)+1;   // Random de 1 a 4
	d.categoria:=n;
end;



procedure agregarOrdenado (var l:lista; d:empleado);  //Agrega ordenado en la lista
  var ant, act, aux: lista;
begin
  new (aux);
  aux^.dato := d;
  act := l;
  while (act <> NIL) and (d.apellido > act^.dato.apellido) do begin
      ant := act;
      act := act^.sig;
  end;
  if (l = act) then
    l := aux
  else
    ant^.sig  := aux;
  aux^.sig := act;
end;


procedure crear (var v:Vector);   // Carga 15 empleados
var
	i:integer;
	d:empleado;
begin
	for i:=1 to 15 do begin
		leer(d);
		agregarOrdenado(v[d.categoria],d); // La posicion del vector es el principio de la lista y la usa como puntero inicial
	end;
end;


procedure inicializar (var v:Vector); //Inicializacion de Vector en nil
var
	i:integer;
begin
	for i:= 1 to 4 do 
	v[i]:=nil;
end;


procedure imprimirVector (v:Vector);
var
	i:integer;
	l:lista;
begin
	for i:=1 to 4 do begin
		l:=v[i];
		writeln ('//------Categoria (',i,')------//');
		while (l<>nil) do begin
	    	writeln('apellido: ',l^.dato.apellido);
	    	writeln('ano de ingreso: ', l^.dato.anoingreso);
	    	writeln('categoria: ',l^.dato.categoria);
	    	l:=l^.sig;
	    	writeln('');
	   	end;
	end;
end;


//--------------------- PROGRAMA PRINCIPAL ---------------------//
var
	v:Vector;
begin
	inicializar(v);
	randomize;
	crear(v);
	imprimirVector(v);
	readln();
	readln();
end.