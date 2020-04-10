program ejercicio;
var
i,dni1,dni2,dni,cantdigito,cantalumnos,digito,n:integer;
promedio,prom1,prom2:real;//prom1 es el primer maximo, prom2 es el segundo mas grande
begin
	dni2:=-1;
	dni1:=-1;
	prom1:=-1;
	prom2:=-1;
	cantalumnos:=0;
	for i:=1 to 500 do
	begin
                writeln('escriba dni: ');
		readln(dni);
                writeln('escriba promedio: ');
		readln(promedio);
		//*********************************************punto1
		if (promedio>prom1) then
		begin
			prom2:=prom1;
			prom1:=promedio;
			dni2:=dni1;
			dni1:=dni;
		end
		else
		begin
		if(promedio>prom2)then
		begin
			prom2:=promedio;
			dni2:=dni;
		end;
                end;
		//************************************* punto2
		cantdigito:=0;
		n:=dni;
		while(n<>0)do
		begin
			digito:= n mod 10;
			if ((digito mod 2)=1) then
			cantdigito:=cantdigito+1;
			n:= n div 10;
		end;
		if (cantdigito>2)and(promedio>6)and(promedio<8) then
		cantalumnos:=cantalumnos+1;

		//*************************************
	        end;
	writeln('1er promedio mas alto es de: ',dni1);
	writeln('2do promedio mas alto es de: ',dni2);
	writeln('la cantidad de alumnos cuyo dni posee a los sumo 3 digitos impares y con promedio entre 6 y 8 son: ',cantalumnos);
        readln(promedio);
end.    