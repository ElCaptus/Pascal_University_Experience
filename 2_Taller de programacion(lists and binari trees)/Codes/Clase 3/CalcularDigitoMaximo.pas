program CalcularDigitoMaximo;
procedure DigitoMaximo (n:integer; var max:integer);
var
	dig:integer;
begin
	if(n<>0) then begin
		dig:=n mod 10;
		if (dig>max) then
			max:=dig;
		DigitoMaximo(n div 10,max);
	end;
end;

var
	n,max:integer;
begin
	max:=-1;
	write('Escribe un numero para calcular su digito maximo: ');
	readln(n);
	DigitoMaximo(n,max);
	writeln('El digito maximo es: ',max);
	readln();
end.