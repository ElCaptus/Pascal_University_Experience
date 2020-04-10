program mergeAcumulador;
const
	dimF = 2;
type
        subDia = 1..31;
        subMes = 1..11;// 11 para corte de control
        subAno = 2000..2018;

        fechaReg = record
		dia: subDia;
		mes: subMes;
		ano: subAno;
	end;
	reg = record
		tipo: integer;
		fecha: fechaReg;
		monto: real;
	end;
	lista=^nodo;
	nodo = record
		dato: reg;
		sig: lista;
	end;
	
	vector = Array [1..dimF] of lista;
	
    {procedimientos 
		creacion de listas:
			agregarOrdenado
			
		merge:
			determinar minimo
			agregaralfinaldelalista
				sumatoria de todos los productos de
	}
	
	//procedimientos
	procedure inicializarVector(var v: vector);
	var
		i: integer;
	begin
		for i:= 1 to dimF do begin
			v[i]:= nil;
		end;
	end;
	
	procedure agregarOrdenado(var l: lista; param: reg);
	var
		nue, ant, act: lista;
	begin
		new(nue);
		nue^.dato:= param;
		ant:= l;
        act:= l;
		while((act <> nil)and(act^.dato.tipo < nue^.dato.tipo)) do begin
			ant:= act;
			act:= act^.Sig;
		end;
		if(ant = act) then l:= nue
		else begin
			ant^.sig:= nue;		
		end;
        nue^.sig:= act;
	end;
	
	procedure crearRegistroRandom(var r: reg);	
        begin
            // 10 tipos de compras, el tipo 11 es para corte de control
            //uso los 1 para evitar los 0 en los campos
            r.tipo:= 1 + random(11);
            r.fecha.dia:= 1 + random(32);
            r.fecha.mes:= 1 + random(13);
	    r.fecha.ano:= 2000 + random(18);
            //uso el 0.1 para evitar un error SIGFPE
            r.monto:= 0.1 + random(10)/ 0.1 + random(10);
	end;
	
	procedure crearListasRandomOrdenadas(var v: vector);
	var
		r: reg;
                i: integer;
	begin
	    for i:=1 to dimF do begin
			crearRegistroRandom(r);
			while(r.tipo <> 11) do begin
				agregarOrdenado(v[i], r);			
				crearRegistroRandom(r);			
			end;			    
	    end;
	end;
	
	procedure imprimirLista(l: lista);
	begin
		while(l <> nil) do begin
			writeln('La compra del tipo ', l^.dato.tipo,' fue realizada el dia ', l^.dato.fecha.dia,'/', l^.dato.fecha.mes,'/',
             l^.dato.fecha.ano, ' y tuvo un costo de: ', l^.dato.monto, '.');
			l:= l^.sig;
		end;
	end;

procedure determinarMinimo(var v: vector; var r: reg);
var
   i, auxI: integer;
   valAlto: integer;
begin
   valAlto:= 13;//me alcanza con 13 porque va de 1 a 11, ya que hice un
   //random de 11
   for i:= 1 to dimF do begin
       if (v[i] <> nil) and (valAlto >= v[i]^.dato.tipo)then begin
          auxI:= i;
          valAlto:= v[i]^.dato.tipo;
       end;
   end;
   if(valAlto <> 13)then begin
      r:= v[auxI]^.dato;
      v[auxI]:= v[auxI]^.sig;
   end
   else r.tipo:= valAlto;
end;

procedure agregarAlFinal(var l, ult: lista; r: reg);
var
   aux: lista;
begin
   new(aux);
   aux^.dato:= r;
   aux^.sig:= nil;
   if(l = nil)then begin
      l:= aux;
   end
   else begin
      ult^.sig:=aux;
   end;
   ult:= aux;
end;

Procedure merge(var v: vector; var l: lista);
var
   r, auxR: reg;
   ult: lista;
begin
     l:= nil;
     determinarMinimo(v,r);
     while(r.tipo <> 13)do begin
         auxR.tipo:= r.tipo;
         auxR.fecha.ano:=0;
         auxR.fecha.mes:=0;
         auxR.fecha.dia:=0;
         auxR.monto:=0;
         while(auxR.tipo = r.tipo)do begin
            auxR.monto:= auxR.monto + r.monto;
            determinarMinimo(v,r);
         end;
         agregarAlFinal(l, ult, auxR);
     end;
end;
procedure imprimirListaMerge(l: lista);
begin
     while(l <> nil) do begin
         writeln('el tipo de producto n°', l^.dato.tipo, 'tuvo un monto de',
         ' compra total de:', l^.dato.monto);
          l:= l^.sig;
     end;
end;

var
	v: vector;
        lMerge: lista;
begin
	randomize;
	inicializarVector(v);
	crearListasRandomOrdenadas(v);
	writeln('Lista n°1: ');
        writeln();
	imprimirLista(v[1]);
        writeln();
        writeln('Lista n°2: ');
        writeln();
        imprimirLista(v[2]);
        merge(v, lMerge);
        writeln('La lista merge es la siguiente: ');
        imprimirListaMerge(lMerge);
        readln();
end.
