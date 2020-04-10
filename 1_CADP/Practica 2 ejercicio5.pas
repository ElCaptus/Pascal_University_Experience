program ejercicio5;
var
cant,i,minc1,minc2,codigo:integer;
minp1,minp2,precio:real;
begin
	minc1,minc2,cant:=0;
	minp1,minp2:=9999;
for i:=1 to 200 do begin
	writeln ('lea codigo: ');
	readln(codigo);
	writeln('lea precio: ');
	readln(precio);
	if (precio<minp1)then begin
		minp2:=minp1;
		minp1:=precio;
		minc2:=minc1;
		minc1:=codigo;
	end
	else begin
		if(precio<minc2)then begin
			minp2:=precio;
			minc2:=codig
		end;
	end;
	if(precio>16)and((codigo mod 2)=0)then
	cant:=cant+1;
end;
writeln(minc1,minc2);
writeln(cant); 
readln(n);
end.
