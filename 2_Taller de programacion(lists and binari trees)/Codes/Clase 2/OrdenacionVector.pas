program OrdenacionVector;
const
	dimF=10;
type
	Vector=array [1..dimF] of integer;

////////////////////////procesos///////////////////////

procedure crearVector (var v:Vector; var dimL:integer);
var
	i,n:integer;
begin
	n:=random(10)+1;
        write ( n ,'-');
	while (n<>5) and (dimL<dimF) do begin
		dimL:=dimL+1;
		v[dimL]:=n;
		n:=random(10)+1;
                write ( n ,'-');
	end;
        writeln();
end;


procedure ordenacionPorInsercion(var v:Vector;dimL:integer);
var
	i,j,d:integer;   // i es el indice del Vector;   j es el auxiliar para comparar los datos;               d es el dato guardado
begin
	for i:=2 to dimL do begin
    	d:=v[i];   //guarda el dato a ordenar
		j:=i-1;
    	while (j > 0) and (v[j] > d) do begin   // se fija si termino de comparar datos (j>0) y compara el dato con
    		v[j+1]:= v[j];
    		j:= j - 1  ;
    	end;
    	v[j+1]:=d;
    end;
end;


procedure imprimirVector(v:Vector;dimL:integer);
var
	i:integer;
begin
     if(dimL<>0) then begin
	for i:=1 to dimL do
	 write('-----');
	 writeln();
	 write(' | ');
	for i:=1 to dimL do
		write(v[i],' | ');
        writeln();
	for i:=1 to dimL do
		write('-----');
     end
     else
     writeln('NO HAY VECTOR');

end;

var
v:Vector;
dimL:integer;
begin
	randomize;
	dimL:=0;      //inicializar
	crearVector(v,dimL);
	ordenacionPorInsercion(v,dimL);
	imprimirVector(v,dimL);
	readln();
	readln();
end. 