program practica7ej6;
{Una empresa de sistemas está desarrollando un software para organizar listas de espera de clientes. Su
funcionamiento es muy sencillo: cuando un cliente ingresa al local, se registra su DNI y se le entrega un
número (que es el siguiente al último número entregado). El cliente quedará esperando a ser llamado por su
número, en cuyo caso sale de la lista de espera. Se pide:
a. Definir una estructura de datos apropiada para representar la lista de espera de clientes.
b. Implementar un programa que:
i. Invoque al módulo RecibirCliente, que recibe como parámetro el DNI del cliente y la lista de clientes
en espera, asigna un número al cliente y retorna la lista de espera actualizada.
ii. Invoque al módulo AtenderCliente, que recibe como parámetro la lista de clientes en espera, y retorne
el número y DNI del cliente a ser atendido y la lista actualizada. El cliente atendido debe eliminarse de
la lista de espera.
Nota: la lista de espera recibe clientes hasta que se lee el DNI 0}
type
	cliente=record
		dni:integer;
		num:integer;
	end;

	lista=^nodo;

	nodo=record
		dato:cliente;
		sig:lista;
	end;

procedure RecibirCliente (dni:integer; var l,ult:lista;var n:integer);   // CARGAR ATRAS
var
	aux:lista;
begin
	new(aux);
	aux^.dato.dni:=dni;
	aux^.dato.num:=n;
	aux^.sig:=nil;
	if(l<>nil) then
		ult^.sig:=aux
	else
		l:=aux;
	ult:= aux;
end;

procedure CargarLista (var l:lista);    // LEER DNI Y CARGAR
var
	dni:integer;
	ult:lista;
	n:integer;
begin
	n:=0;
	ult:=nil;
    writeln('Escriba DNI: ');
	readln(dni);
	while (dni<>0)do begin
		n:= n+1;
		RecibirCliente(dni,l,ult,n);
		writeln('Escriba DNI: ');
		readln(dni);
	end;
end;

procedure AtenderCliente (var l:lista); //   IMPRIME DNI Y NUMERO Y BORRA ELEMENTO PASANDO AL SIGUIENTE DEVUELVE LA LISTA ACTUALIZADA
var
aux:lista;
begin
	writeln('DNI: ',l^.dato.dni);
	writeln('Numero: ',l^.dato.num);
	aux:=l;
	l:=l^.sig;
	aux^.sig:=nil;
	dispose(aux);
end;

procedure RecorrerLista (var l:lista);  //  RECORRE LISTA
begin 
	while (l<>nil)do
		AtenderCliente(l);
end;
//////////////////////////////////////// PROGRAMA PRINCIPAL ////////////////////////////////////////
var
l:lista;
begin
	l:=nil;
	CargarLista(l);
	RecorrerLista(l);
	writeln('termino');
	readln
end.