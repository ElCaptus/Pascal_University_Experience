Program project1;
type
    alumnos=record
      cod:integer;
      nya:String[20];
      cantSinF:integer;
      cantConF:integer;
    end;
    info =record
      cod:integer;
      final:integer;
      cursada:integer;
    end;
    archivo_detalle = file of info;

    archivo_alumnos = file of alumnos;




 procedure leertxtM(var  txt:text; var a:alumnos);
 begin
      if(not eof(txt))then
        readln(txt,a.cod,a.nya,a.cantSinF,a.cantConF)
      else
          a.cod:=-1;
end;

procedure crearArchM(var arch:archivo_alumnos);
var
   nom_fis:String;
   a:alumnos;
   txt:text;
begin
     writeln('Ingrese el nombre que quiere designarle al archivo de alumnos');
     readln(nom_fis);
     assign(arch,nom_fis);
     assign(txt,'alumnos.txt');
     reset(txt);
     rewrite(arch);
     leertxtM(txt,a);
     while(a.cod<>-1)do begin
       write(arch,a);
       leertxtM(txt,a);
     end;
     close(arch);
     close(txt);
end;

procedure leertxtD(var txt:text; var i:info);
 begin
      if(not eof (txt))then
        readln(txt,i.cod,i.final,i.cursada)
       else
        i.cod:=-1;
 end;


procedure crearArchD (var detalle:archivo_detalle);
var
   nom_fis:String;
   i:info;
   txt:text;
begin
     writeln('Ingrese el nombre que quiere designarle al archivo detalle');
     readln(nom_fis);
     assign(detalle,nom_fis);
     assign(txt,'detalle.txt');
     reset(txt);
     rewrite(detalle);
     leertxtD(txt,i);
     while(i.cod<>-1)do begin
       write(detalle,i);
       leertxtD(txt,i);
     end;
     close(detalle);
     close(txt);
end;

procedure mostrar(a: alumnos);
begin
      writeln();
      writeln('--------------------------------------------');
      Writeln('Codigo del alumno: ', a.cod);
      Writeln('Nombre y apellido del alumno: ', a.nya);
      Writeln('Cantidad de materias aprobadas sin final: ', a.cantSinF);
      Writeln('Cantidad de materias aprobadas con final: ', a.cantConF);
      writeln('--------------------------------------------');
      writeln();
end;

procedure leerArchD(var arch:archivo_detalle;var i:info);
 begin
      if(not eof(arch))then
         read(arch,i)
       else
        i.cod:=-1;
 end;

procedure listarArchD (var arch: archivo_detalle);
var
   i:info;
   txt:text;
   s:string;
begin
     writeln('Ingrese el nombre que quiere designarle al txt de detalle');
     readln(s);
     assign(txt,'reporteDetalle.txt');
     reset(arch);
     rewrite(txt);
     leerArchD(arch,i);
     while(i.cod<>-1)do begin
       writeln(txt,'codigo de alumno: ',i.cod, ' cursada aprobada: ',i.cursada, ' con final: ', i.final);
       leerArchD(arch,i);
     end;
     close(arch);
end;

procedure leerArchM(var arch:archivo_alumnos;var a:alumnos);
 begin
      if(not eof(arch))then
         read(arch,a)
       else
        a.cod:=-1;
 end;

procedure listarArchA (var arch: archivo_alumnos);
var
   a:alumnos;
   txt:text;
   s:string;
begin
     writeln('Ingrese el nombre que quiere designarle al txt de alumnos');
     readln(s);
     assign(txt,'reporteAlumnos.txt');
     reset(arch);
     rewrite(txt);
     leerArchM(arch,a);
     while(a.cod<>-1)do begin
       writeln(txt,'codigo de alumno: ',a.cod,' Nombre y Apellido del alumno ',a.nya , ' cursada aprobada: ',a.cantSinF, ' con final: ', a.cantConF);
       leerArchM(arch,a);
     end;
     close(arch);
     close(txt);
end;

Procedure acumulador (var maes:archivo_alumnos;var deta:archivo_detalle ) ;
var
   a:alumnos;
   i:info;
begin
   reset(deta);
   reset(maes);
   leerArchD(deta,i);
   leerArchM(maes,a);
   while(a.cod<>-1)do begin
     while(a.cod<> i.cod)and (a.cod<>-1)do
         leerArchM(maes,a);
     while(a.cod=i.cod)do begin
         a.cantConF:=a.cantConF+i.final;
         a.cantSinF:=a.cantSinF+i.cursada;
         leerArchD(deta,i);
     end;
     seek(maes,filepos(maes)-1);
     write(maes,a);
   end;
    close(deta);
    close(maes);
end;

procedure listarMalaLeche(var arch:archivo_alumnos);
var
   a:alumnos;

begin
     reset(arch);
     leerArchM(arch,a);
     while(a.cod<>-1)do begin
       if(a.cantSinF>4)then
          mostrar(a);
       leerArchM(arch,a);
     end;
     close(arch);

end;

var
   maes:archivo_alumnos;
   deta:archivo_detalle;
begin
     writeln('Crear archivo maestro');
     crearArchM(maes);
     readln();
     writeln('Crear archivo detalle');
     crearArchD(deta);
     readln();
     writeln('Listar archivo alumnos en un txt');
     listarArchA(maes);
     readln();
     writeln('Listar archivo detalle en un txt');
     listarArchD(deta);
     readln();
     writeln('actualizar el maestro');
     acumulador(maes,deta);
     readln();
     writeln('Listar a los que le faltan mas de 4 finales');
     listarMalaLeche(maes);
     readln();
end.
