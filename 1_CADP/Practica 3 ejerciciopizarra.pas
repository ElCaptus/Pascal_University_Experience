program asdf;

procedure calcularmaximo(n:integer;var m:integer);
var
begin
if(n>m)then
	m:=n;
end;
function divisores (max:integer):integer;
var
cant,i:integer;
begin
	cant:=0;
	for i:=1 to max do begin
		if ((max mod i) = 0) then
		cant:=cant+1;
	end;
	divisores:=cant;

end;

function digitomasgrande(n:integer):integer;
var
d,m:integer;
begin
	m:=0;
	while (n<>0)do begin
		d:=n mod 10;
		calcularmaximo(d,m);
		n:=n div 10;
	end;
	digitomasgrande:=m;
end;

var
n,max:integer;
begin
	m:=0;
	readln(n);
	while (n<>0)do begin
	calcularmaximo(n,max);
	readln(n);
	end;
	writeln('el digto mas grande de el ultimo numero (',n,'): ',digitomasgrande(n));
	writeln('la cantidad de divisores del numero mas grande leido (',max,'): ',divisores(max));
end.