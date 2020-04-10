program ImprimirDigitosEnAmbosSentidos;
procedure DigitosNormal (n:integer);
begin
	if(n<>0) then begin
                DigitosNormal(n div 10);
		writeln(n mod 10);
	end;
end;

procedure DigitosInverso(n:integer);
begin
	if (n<>0) then begin
		writeln(n mod 10);
		DigitosInverso(n div 10);
	end;
end;

var
	n:integer;
begin
	write('Escribe un numero: ');
	readln(n);
	writeln('Digitos en sentido normal: ');
	DigitosNormal(n);
	writeln('Digitos en sentido inverso: ');
	DigitosInverso(n);
	readln();
end.          