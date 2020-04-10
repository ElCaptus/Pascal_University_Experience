/////////////////////					/////////////////////								///////////////////	
//LISTANIVEL PROGRAMA NO EXPLICADO
	listaNivel=^nodoAS;
	nodoAS=record
		sig:ListaNivel;
		info:arbol;
	end;


{-----------------------------------------------------------------------------
CONTARELEMENTOS - Devuelve la cantidad de elementos de una lista l }

function ContarElementos (l: listaNivel): integer;
  var c: integer;
begin
 c:= 0;
 While (l <> nil) do begin
   c:= c+1;
   l:= l^.sig;
 End;
 contarElementos := c;
end;


{-----------------------------------------------------------------------------
AGREGARATRAS - Agrega un elemento atr�s en l}

Procedure AgregarAtras (var l, ult: listaNivel; a:arbol);
 var nue:listaNivel;

 begin
 new (nue);
 nue^.info := a;
 nue^.sig := nil;
 if l= nil then l:= nue
           else ult^.sig:= nue;
 ult:= nue;
 end;


{-----------------------------------------------------------------------------
IMPRIMIRPORNIVEL - Muestra los datos del �rbol a por niveles }

Procedure imprimirpornivel(a: arbol);
var
   l, aux, ult: listaNivel;
   nivel, cant, i: integer;
begin
   l:= nil;
   if(a <> nil)then begin
    nivel:= 0;
    agregarAtras (l,ult,a);
    while (l<> nil) do begin
      nivel := nivel + 1;
      cant:= contarElementos(l);
      write ('Nivel ', nivel, ': ');
      for i:= 1 to cant do begin
        write (l^.info^.dato, ' - ');
        if (l^.info^.izq <> nil) then agregarAtras (l,ult,l^.info^.izq);
        if (l^.info^.der <> nil) then agregarAtras (l,ult,l^.info^.der);
        aux:= l;
        l:= l^.sig;
        dispose (aux);
      end;
      writeln;
    end;
  end;
end;

////////////////							///////////////									//////////////////

