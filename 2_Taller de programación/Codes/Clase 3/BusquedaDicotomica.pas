program BusquedaDicotomica;
const
  dimF=10;
type
  Vector=array [1..dimF] of integer;

////////////////////////procesos///////////////////////

procedure ordenacionPorInsercion(var v:Vector);
var
  i,j,d:integer;   // i es el indice del Vector;   j es el auxiliar para comparar los datos;               d es el dato guardado
begin
  for i:=2 to dimF do begin
      d:=v[i];   //guarda el dato a ordenar
      j:=i-1;
      while (j > 0) and (v[j] > d) do begin   // se fija si termino de comparar datos (j>0) y compara el dato con
        v[j+1]:= v[j];
        j:= j - 1  ;
      end;
      v[j+1]:=d;
    end;
end;

    procedure imprimirVector(v:Vector; pos: integer);
    var
      i:integer;
    begin
        for i:=1 to dimF do
          write('-----');
      writeln();
      write(' | ');
      for i:=1 to dimF do
        write(v[i],' | ');
        writeln();
        for i:=1 to dimF do begin
            if(i = pos) then write('--|--')
            else write('-----');
        end;
        writeln();
    end;

    procedure crearVector (var v:Vector; pos: integer);
    var
      i,n:integer;
    begin
      for i:= 1 to dimF do begin
        n:=random(100)+1;
        v[i]:=n;
    end;
      ordenacionPorInsercion(v);
    imprimirVector(v,pos);
    end;

procedure busquedaDicotomica( v: vector; ini,fin: integer; dato:integer; var pos: integer);
var
  i:integer;
begin
  pos:=(ini +fin)div 2;
  imprimirVector(v,pos);
  if(v[pos]= dato) then begin
      writeln('el dato esta en la posicion ',pos,'del vector.');
    end
  else begin
    if(pos=fin)then
      writeln('no se encuentra en el vector.')
    else begin
      if(v[pos]>dato) then begin

        busquedaDicotomica(v,ini,pos-1,dato,i);
      end
      else begin

        busquedaDicotomica(v,pos+1,fin,dato,i);
      end;
    end;
  end;
end;

var
  v:Vector;
  dato, pos: integer;
begin
    randomize;
    pos:= 0;
    crearVector(v,pos);
    writeln('Que numero quiere buscar en el Vector? ');
    readln(dato);
    busquedaDicotomica(v,1,dimF,dato,pos);
    readln();
end. 