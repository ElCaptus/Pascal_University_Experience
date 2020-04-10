program Merge4listas;
uses sysutils;
const 
 dimF=4;
 emp=15; //cantidad de empleados totales
type
	rango=1980..2018;   //rango de ingreso
	tipo=1..dimF;                  
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
	Vector= array [1..dimF] of Lista;
//----------------------------Procedimientos------------------------------------//
procedure leer (var d:empleado);
//var
	//n:integer;
	//a:cadena20; --> ESTAS VARIABLES NO SON NECESARIAS, HAY QUE LEER DIRECTAMENTE SOBRE EL REGISTRO
begin
	write('Ingrese el apellido: ');
	//readln(a);
    //d.apellido := a;
    d.apellido := 'APELLIDO_' + IntToStr(random(9));
    writeln(d.apellido);

	//n:= random(39)+1980; // Random de 1980 a 2018
	//d.anoingreso:=n;
   	write('Ingrese el anio de ingreso: ');
    d.anoingreso := random(39)+1980;
    writeln(d.anoingreso);

	//n:= random(dimF)+1;   // Random de 1 a 4
	//d.categoria:=n;
    write('Ingrese la categoria: ');
    d.categoria:= random(dimF)+1;
    writeln(d.categoria);
    writeln('-----------------------------------------');
end;




procedure agregarOrdenado (var l:Lista; d:empleado);  //Agrega ordenado en la lista
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


procedure crear (var v:Vector);  
var
	i:integer;
	d:empleado;
begin
	for i:=1 to emp do begin
		leer(d);
		agregarOrdenado(v[d.categoria],d); // La posicion del vector es el principio de la lista y la usa como puntero inicial
	end;
end;


procedure inicializar (var v:Vector); //Inicializacion de Vector en nil
var
	i:integer;
begin
	for i:= 1 to dimF do 
	v[i]:=nil;
end;


procedure imprimirVector (v:Vector);
var
	i:integer;
	l:lista;
begin
	for i:=1 to dimF do begin
		l:=v[i];
		writeln ('//------Categoria (',i,')------//');
        //--> DEBERIA MODULARIZAR LA IMPRESION DE LA LISTA
		while (l<>nil) do begin
	    	writeln('apellido: ',l^.dato.apellido);
	    	writeln('ano de ingreso: ', l^.dato.anoingreso);
	    	writeln('categoria: ',l^.dato.categoria);
	    	l:=l^.sig;
	    	writeln('');
	   	end;
	end;
end;


procedure agregarAtras(var l, ult: lista; n:empleado);
  var
    aux:lista;
  begin
    new(aux);
    aux^.dato := n;
    aux^.sig := nil;
    if (l <> nil) then
      ult^.sig := aux
    else
      l := aux;
  ult:= aux;
  end;

function hayEmpleados (v:Vector):boolean;
var
	t:boolean;
	//i:integer; --> VARIABLE NO UTILIZADA
begin
	t:=true;
	if(v[1]=nil)and(v[2]=nil)and(v[3]=nil)and(v[4]=nil)then	t:=false;
	hayEmpleados:=t;
end;


procedure merge (var v:Vector;var l:Lista);
var
	min:cadena20;
	i,pos:integer;
	ult:Lista;
begin
	ult:=nil;
	while (hayEmpleados(v))do begin
		min:='zzz';              // inicializar variable en valor maximo
		for i:=1 to dimF do begin
			if(v[i]<>nil)and(v[i]^.dato.apellido<min)then begin
				min:=v[i]^.dato.apellido;
				pos:=i;
			end;
		end;
        //--> ESTAN MAL LOS PARAMETROS, PASCAL INDICA ERROR
		//agregarAtras(l,ult,v[pos]^.dato.apellido);
        agregarAtras(l,ult,v[pos]^.dato);
		v[pos]:=v[pos]^.sig;
        //--> FALTA HACER EL DISPOSE DE LOS ELEMENTOS QUE SE DEJAN DE APUNTAR EN LA LISTA
	end;
end;


procedure imprimirMerge(l:Lista);
begin
	writeln('-----------------------------');
	while (l<>nil)do begin
		write(l^.dato.apellido, ' | ');
		l:=l^.sig;
	end;
end;

//--------------------- PROGRAMA PRINCIPAL ---------------------//
var
	l:Lista;
	v:Vector;
begin
	inicializar(v);
	randomize;
	crear(v);
	imprimirVector(v);
	merge(v,l);
	imprimirMerge(l);
	readln();
	readln();
end.
