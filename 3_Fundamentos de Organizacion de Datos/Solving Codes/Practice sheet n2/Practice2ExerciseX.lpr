program project1;
type
  st40= string[40];
  producto = record
    codigo:integer;
    descripcion: st40;
    precio: real;
    stockactual:integer;
    stockminimo:integer;
  end;
  pedido = record
    codigo: integer;
    cantidad:integer;
  end;

  ArchivoDeProductos=file of producto;
  ArchivoDePedidos=file of pedido;
  detalles= array [1..4] of ArchivoDePedidos;
  detallesTxt= array[1..4] of text;
procedure leerTextoMaestro(var mae:ArchivoDeProductos);
var
  m:text;
  r:producto;
begin
  assign(mae,'maestroB');
  rewrite(mae);
  assign(m,'maestro.txt');
  reset(m);
  while(not eof(m)) do begin
     writeln('sd');
     read(m, r.codigo, r.precio, r.stockactual, r.stockminimo, r.descripcion);
     write(mae,r);
  end;
  close(mae);
  close(m);
end;

procedure leerTextoDetalle(var det:detalles);
var
  st:st40;
  i:integer;
  p:pedido;
  det1:detallesTxt;
begin
  for i:=1 to 4 do begin
     if(i=1)then st:='Det1.txt'
     else if(i=2) then  st:='Det2.txt'
     else if(i=3) then  st:='Det3.txt'
     else st:='Det4.txt';
     assign(det1[i],st);
     reset(det1[i]);
  end;
  for i:=1 to 4 do begin
     if(i=1)then st:='Det11'
     else if(i=2) then  st:='Det22'
     else if(i=3) then  st:='Det33'
     else st:='Det44';
     assign(det[i],st);
     rewrite(det[i]);
     while(not eof(det1[i])) do begin
         readln(det1[i],p.codigo, p.cantidad);
         write(det[i],p);
     end;
  end;
  for i:=1 to 4 do begin
      close(det[i]);
      close(det1[i]);
  end;
end;

procedure escribirBinario(var maestro:ArchivoDeProductos);
var
  r:producto;
begin
  reset(maestro);
  while (not eof(maestro))do begin
     read(maestro,r);
     with r do
          writeln(codigo,' ', descripcion,' ', precio,' ', stockactual,' ', stockminimo);
  end;
end;

procedure calcularMinimo(var det:detalles;var min:pedido);  //Si no hay mas
var
  i:integer;
  x:pedido;
begin
  min.codigo:=999;
  for i:=1 to 4 do begin
     if (not eof(det[i])) then begin                       //Si no termino de recorrer la carpeta
        read(det[i],x);                                    //Lee el elemento y lo guarda en x
        if(x.codigo<min.codigo)then begin                             //Si el codigo de x es menor al minimo
            min:=x;                                        //Actualiza minimo
        end
        else begin
            seek(det[i],filepos(det[i])-1);                //Si no, retrocede una posicion
        end;
     end;
  end;
end;

procedure ActualizarMaestro (var det:detalles;var m:ArchivoDeProductos);
var
  hayElementos: boolean;
  xpedido:pedido;
  xmaestro:producto;
begin
  hayElementos:=true;
  reset(m);
  reset(det[1]);
  reset(det[2]);
  reset(det[3]);
  reset(det[4]);
  while(hayElementos)do begin
       calcularMinimo(det,xpedido);
       if(xpedido.codigo <> 999) then begin                      //Si hay elemento minimo
          read(m,xmaestro);
          while(xmaestro.codigo<>xpedido.codigo) do begin  //Mientras no encuentre el pedido en el maestro
             read(m,xmaestro);                          //Sigo leyendo
          end;
          seek(m,filepos(m)-1);                         //Acomoda el maestro en el lugar donde encontro el elemento
          xmaestro.stockactual:=xpedido.cantidad;
          write(m,xmaestro);
          seek(m,filepos(m)-1);                         //Vuelve a acomodar el maestro ya que puede haber mas de 2 pedidos del mismo producto
       end
       else
           hayElementos:= false;
  end;
end;

var
  maestro:ArchivoDeProductos;
  detalle:detalles;
begin
  leerTextoDetalle(detalle);
  leerTextoMaestro(maestro);
  escribirBinario(maestro);
  actualizarMaestro(detalle,maestro);
  readln();
  readln();
end.



















