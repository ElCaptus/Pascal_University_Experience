program Practica2ejercicio3;
var
n,max,min,suma:integer;
begin
	suma:=0;
	max:=-9999;
	min:=9999;
	repeat
	read(n);
	suma:=suma+n;
	if (n>max)then
	max:=n;
	if (n<min)then
	min:=n;
	until (n=100);
	writeln(max);
	writeln(min);
	writeln(suma);

end.