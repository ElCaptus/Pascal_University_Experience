program Pr1Ej2;
type
  archivo = file of integer;
var
  arc : archivo;
  contMas10mil,contMul2,i : integer;
  nombre_fisico: string[20];
begin
  //EJERCICIO1
  writeln('Nombre del archivo a crear: ');
  readln(nombre_fisico);
  assign(arc,nombre_fisico);
  rewrite(arc);
  writeln('Escriba los numeros que quiera agregar al archivos, corta en 0.');
  readln(i);
  while(i<>0) do begin
    write(arc,i);
    readln(i);
  end;
  writeln('Cierro');
  close(arc);
  //EJERCICIO 2 COMPLEMENTADO CON EL 1
  writeln('Escriba el nombre del archivo que quiere abrir');
  readln(nombre_fisico);
  assign(arc,nombre_fisico);
  writeln('Abro');
  reset(arc);
  contMas10mil:=0;
  contMul2:=0;
  read(arc,i);
  while(not eof(arc))do begin
    writeln(i);
    if (i>100000) then
    contMas10mil:=contMas10mil+1;
    if (i mod 2 = 0) then
    contMul2:=contMul2+1;
    read(arc,i);
  end;
  close(arc);
  writeln('Hay ',contMul2,' numeros en el archivo que son multiplos de 2 y ',contMas10mil,' numeros mayores a 100000');
  readln();
  readln();
end.

