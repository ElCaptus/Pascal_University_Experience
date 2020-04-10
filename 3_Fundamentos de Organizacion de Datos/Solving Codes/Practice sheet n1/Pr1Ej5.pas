program Pr1Ej5;
  str20=string[20];
  articulo= record
    nombre:str20;
    descripcion:string[];
    precio:real;
    stock:integer;
  end;
  articulos= file of articulo;
// ************************************************************//
procedure CrearArchivoDeArticulos(var arc:articulos);
var
  a:articulo;
  zapatos:text;
begin
  assign(zapatos,zapatos.txt);
  reset(zapatos)
  assign(arc,ArchivoBinarioZapatos);
  rewrite(arc);
  while (not eof(zapatos))do begin
    with a do begin
         readln(zapatos,precio,nombre);
         readln(zapatos,stock,descripcion);
    end;
    write(arc,a);
  end;
  close(arc);
  close zapatos;
end;
procedure ListarArticulosDePocasUnidades(var arc:articulos);
var
  a:articulos;
begin
  reset(arc);
  while(not eof(arc))do begin
    read(arc,a);
    if(a.unidades<100)then
      writeln('El producto ',a.nombre,' tiene  ',a.stock,' unidades en stock');
  end;
  close(arc);
end;
procedure ExportarZapateria(var arc:articulos);
var
  a:articulo;
  txt:text;
begin
  reset(arc);
  assign(txt,zapateria.txt);
  rewrite(txt);
  while(not eof(arc))do begin
    read(arc,a);
    with a do
         writeln(txt,nombre,descripcion,precio,stock);
  end;
  close(arc);
  close(txt);
end;

var
  i:integer;
  arc:articulos;
begin
  writeln('0_ Salir del programa.');
  writeln('1_ Crear archivo de articulos.  (desde zapatos.txt)');
  writeln('2_ Listar articulos que hayan menos de 100 unidades.');
  writeln('3_ ');
  writeln('4_ Exportar archivo de articulos. (zapateria.txt)');
  readln(i);
  while(i<>0)do begin
    case i of
        1: CrearArchivoDeArticulos(arc);
        2: ListarArticulosDePocasUnidades(arc);
        3:;
        4: ExportarZapateria(arc);
    end;
  end;
end.

