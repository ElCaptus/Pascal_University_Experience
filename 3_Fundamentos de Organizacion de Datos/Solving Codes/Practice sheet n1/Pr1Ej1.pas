program Pr1Ej1;
type
  archivo= file of integer;
var
  arc: archivo;
  i: integer;
  nombre_fisico:string[20];
begin
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
  writeln('Abro');
  reset(arc);
  read(arc,i);
  while(not eof) do begin
    writeln(i);
    read(arc,i);
  end;
  close(arc);
end.

