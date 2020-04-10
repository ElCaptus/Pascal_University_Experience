program Pr1Ej4;
uses
    Crt;
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

procedure Listar(var arc:ArchivoDePersonas);
var
  p:persona;
begin
  reset(arc);
  while (not eof(arc))do begin
        read(arc,p);
        with p do
             writeln(nombre,' ', apellido);
  end;
  close(arc);
  readln();
end;
procedure Listar18(var arc:ArchivoDePersonas);
var
  p:persona;
begin
  reset(arc);
  while (not eof(arc))do begin
        read(arc,p);
        if (p.edad>18) then
           with p do
             writeln(nombre,' ', apellido);
  end;
  close(arc);
  readln();
end;
procedure crearArchivo(var arc:ArchivoDePersonas);
var
   nombre_fisico:string[40];
begin
  ClrScr;
  writeln('Escriba el nombre del archivo a crear:');
  readln(nombre_fisico);
  assign(arc,nombre_fisico);
  rewrite(arc);
  Leer(arc);
  close(arc);
end;

procedure ListarApellidoDet(var arc:ArchivoDePersonas);
var
   ap:str20;
   p:persona;
begin
  reset(arc);
  writeln('Escriba el apellido para listarle todas las personas con ese apellido: ');
  readln(ap);
  while(not eof(arc))do begin
    read(arc,p);
    if(p.apellido=ap)then begin
      writeln(p.apellido,' ',p.nombre);
    end;
  end;
  close(arc);
  readln();
end;

procedure AgregarPersonas(var arc:ArchivoDePersonas);
begin
  reset(arc);
  seek(arc,filesize(arc)-1);
  Leer(arc);
  close(arc);
end;
procedure ModificarEdad(var arc:ArchivoDePersonas);
var
   p:persona;
   dni:integer;
   esta:boolean;
begin
  reset(arc);
  ClrScr;
  writeln('Escriba el dni de la persona que quiere modificar la edad: (ingrese 0 para volver al menu inicial)');
  readln(dni);
  if(dni<>0)then begin
    esta:=false;
    while(not eof(arc)and not esta)do begin
      read(arc,p);
      if(dni=p.dni)then
         esta:=true;
    end;
    if(esta) then begin
       writeln(p.apellido,' ',p.nombre,' ',p.edad,' a;os');
       writeln('Escriba que edad le quiere poner');
       readln(dni);
       p.edad:=dni;
       writeln('Quiere guardar la edad?');
       writeln('1_ si');
       writeln('2_ no');
       readln(dni);
       if(dni=1)then begin
          seek(arc,filepos(arc)-1);
          write(arc,p);
          writeln('Guardado Con Exito!');
       end;
    end;
  end;
end;

procedure exportarTxt(var arc:ArchivoDePersonas);
var
   archivotexto:text;
   p:persona;
begin
  reset(arc);
  assign(archivotexto,'personas');
  rewrite(archivotexto);
  while(not eof(arc))do begin
    read(arc,p);
    with p do
      writeln(archivotexto, apellido,' ', nombre,', ', edad,' años  DNI: ', dni);
  end;
  close(archivotexto);
end;

procedure exportarTxtErroneo(var arc:ArchivoDePersonas);
var
   archivotexto:text;
   p:persona;
begin
  reset(arc);
  assign(archivotexto,'erroneo');
  rewrite(archivotexto);
  while(not eof(arc))do begin
    read(arc,p);
    if(p.dni=0)then
    with p do
      writeln(archivotexto, apellido,' ', nombre,', ', edad,'años  DNI: ', dni);
  end;
  close(archivotexto);
end;


procedure menu(var arc:ArchivoDePersonas);
var
   nombre_fisico:str20;
   opc:integer;
begin
  writeln('0_ Cerrar archivo.');
  writeln('1_ Crear Archivo.');
  writeln('2_ Abrir Archivo.');
  readln(opc);
  while(opc<>0) do begin
    case opc of
         1:      crearArchivo(arc);
         2: begin
              ClrScr;
              writeln('0_ Menu de inicio.');
              writeln('1_ Abrir archivo especifico.');
              writeln('2_ Listar todas las personas.');
              writeln('3_ Listar las personas +18.');
              writeln('4_ Listar Apellido Determinado.');
              writeln('5_ Agregar personas al archivo.');
              writeln('6_ Modificar edad a personas.');
              writeln('7_ Exportar archivo personas.txt.');
              writeln('8_ Exportar archivo erroneos.txt');
              readln(opc);
              case opc of
                   0: writeln('JEJEJJEJEJEJEEJJEJJE');
                   1:begin
                     ClrScr;
                     writeln('Escriba el nombre del archivo existente que quiere abrir.');
                     readln(nombre_fisico);
                     assign(arc,nombre_fisico);
                   end;
                   2: Listar(arc);
                   3: Listar18(arc);
                   4: ListarApellidoDet(arc);
                   5: AgregarPersonas(arc);
                   6: ModificarEdad(arc);
                   7: ExportarTxt(arc);
                   8: exportarTxtErroneo(arc);
              end;
         end;
    end;
    ClrScr;
    writeln('0_ Cerrar archivo.');
    writeln('1_ Crear Archivo.');
    writeln('2_ Abrir Archivo.');
    readln(opc);
  end;
end;

var
  arc:ArchivoDePersonas;
begin
  menu(arc);
end.
