program Pr1Ej3;
type
  str20=string[20];
  persona = record
    apellido:str20;
    nombre:str20;
    edad:integer;
    dni:integer;
  end;
  ArchivoDePersonas= file of persona;
//////////////////////////////////////
procedure Leer(var a:ArchivoDePersonas);
var
  p:persona ;
begin
  writeln('Escriba su apellido: ');
  readln(p.apellido);
  while(p.apellido<>'')do begin
    writeln('Escriba su nombre: ');
    readln(p.nombre);
    writeln('Escriba su edad: ');
    readln(p.edad);
    writeln('Escriba su dni: ');
    readln(p.dni);
    write(a,p);
    writeln('*********Aca otra persona: *********');
    writeln('Escriba su apellido: ');
    readln(p.apellido);
  end;
end;

var
  nombre_fisico:str20;
  ap:persona;
  arc:ArchivoDePersonas;
  i:integer;
begin
  writeln('Escriba el nombre del archivo a crear:');
  readln(nombre_fisico);
  assign(arc,nombre_fisico);
  rewrite(arc);
  Leer(arc);
  close(arc);
  reset(arc);
  writeln('Escriba el apellido para listarle todas las personas con ese apellido: ');
  readln(nombre_fisico);
  read(arc,ap);
  while(not eof(arc))do begin
    if(ap.apellido=nombre_fisico)then begin
      writeln(ap.apellido,' ',ap.nombre);
    end;
    read(arc,ap);
  end;
  if(ap.apellido=nombre_fisico)then
    writeln(ap.apellido,' ',ap.nombre);
  close(arc);
  writeln('*******TODAS LAS PERSONAS SON:  *****');
  reset(arc);
  read(arc,ap);
  while(not eof(arc))do begin
    writeln(ap.apellido,' ',ap.nombre);
    read(arc,ap);
  end;
  writeln(ap.apellido,' ',ap.nombre);
  close(arc);
  writeln('*****TODAS LAS PERSONAS +18: ******');
  reset(arc);
  read(arc,ap);
  while(not eof(arc))do begin
    if(ap.edad>=18)then
      writeln(ap.apellido,' ',ap.nombre);
    read(arc,ap);
  end;
  if(ap.edad>=18)then
      writeln(ap.apellido,' ',ap.nombre);
  close(arc);
  readln();
  readln();
end.















