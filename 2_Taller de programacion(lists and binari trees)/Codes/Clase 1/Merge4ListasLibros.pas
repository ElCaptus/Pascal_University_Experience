program Merge4listas;
const 
 dimF=4;
type
	Subrango=0..11;	

	Lista=^ Nodo;     
	Nodo = record
	  dato: Subrango;
	  sig:Lista;
	 end;
	Vector= array [1..dimF] of Lista;
//----------------------------Procedimientos------------------------------------//
procedure leer (var d:Subrango);
begin
	write('Escribe el ISBN: ');	
	d:= random(12);
	writeln(d);
end;



procedure agregarOrdenado (var l:Lista; d:Subrango);  //Agrega ordenado en la lista
  var ant, act, aux: lista;
begin
  new (aux);
  aux^.dato := d;
  act := l;
  while (act <> NIL) and (d > act^.dato) do begin
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
	d:Subrango;
begin
	for i:=1 to dimF do begin
		leer(d);
		while (d<>11)do begin
			agregarOrdenado(v[i],d); // La posicion del vector es el principio de la lista y la usa como puntero inicial
			leer(d);
		end;
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
		while (l<>nil) do begin
	    	writeln('ISBN: ',l^.dato);
	    	writeln('');
	    	l:=l^.sig
	   	end;
	end;
end;


procedure agregarAtras(var l, ult: lista; n:Subrango);
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

function hayLibro (v:Vector):boolean;
var
	t:boolean;
	i:integer;
begin
	t:=true;
	if(v[1]=nil)and(v[2]=nil)and(v[3]=nil)and(v[4]=nil)then	t:=false;
	hayLibro:=t;
end;


procedure merge (var v:Vector;var l:Lista);
var
	min:Subrango;
	i,pos:integer;
	ult:Lista;
begin
	ult:=nil;
	while (hayLibro(v))do begin
		min:=11;              // inicializar variable en valor maximo
		for i:=1 to dimF do begin
			if(v[i]<>nil)and(v[i]^.dato<min)then begin
				min:=v[i]^.dato;
				pos:=i;
			end;
		end;
		agregarAtras(l,ult,v[pos]^.dato);
		v[pos]:=v[pos]^.sig;
	end;
end;


procedure imprimirMerge(l:Lista);
begin
	writeln('-----------------------------');
	while (l<>nil)do begin
		write(' ',l^.dato);
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