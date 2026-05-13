Program Pzim;

type
  tipo_inf = integer;
  ponteiro = ^elemento;
  elemento = record
    dado: tipo_inf;
    prox: ponteiro
  end;

var
  fila      : ponteiro;
  num       : tipo_inf;
  op        : byte;
  continuar : boolean;

procedure create_fila_nill(var filaE: ponteiro);
begin
  filaE := nil;
end;

procedure ler_num(number: tipo_inf);   // << erro de lógica aqui, não toquei
begin
  writeln('Digite um valor: ');
  readln(number);
end;

procedure incluir(var filaE: ponteiro; number: tipo_inf);
var
  node, aux: ponteiro;
begin
  new(node);
  if (node = nil) then
    writeln('MEMÓRIA CHEIA')
  else
    begin
      if (filaE = nil) then
        begin
          node^.dado := number;
          node^.prox := filaE;
          filaE := node;
        end
      else
        begin
          aux := filaE;
          while (aux^.prox <> nil) do
            aux := aux^.prox;
          node^.dado := number;
          node^.prox := nil;
          aux^.prox := node;
        end;
    end;
end;

procedure remover(var filaE: ponteiro);
var aux: ponteiro;
begin
  if (filaE = nil) then
    writeln('Fila Vazia, nada para remover')
  else
    begin
      aux := filaE;
      filaE := aux^.prox;
      writeln('Foi removido o elemento ', aux^.dado, '!');
      dispose(aux);
    end;
end;

function consultar(filaE: ponteiro): tipo_inf;
var
  i   : integer;
  aux : ponteiro;
begin
  if (filaE = nil) then
    begin
      i := 0;
      writeln('Fila Vazia, nada para exibir');
    end
  else
    begin
      aux := filaE;
      i := 0;
      while aux <> nil do
        begin
          i := i + 1;
          writeln(i, ' - ', aux^.dado);
          aux := aux^.prox;
        end;
    end;
  consultar := i;
end;

Begin
  continuar := True;
  num := 0;
  create_fila_nill(fila);

  while continuar = True do
    begin
      writeln('1 - INCLUIR');
      writeln('2 - REMOVER PRIMEIRO');
      writeln('3 - CONSULTAR');
      writeln('4 - SAIR');
      writeln('O que deseja fazer?');
      readln(op);

      if op = 1 then
        begin
          ler_num(num);
          incluir(fila, num);
        end;
      if op = 2 then
        remover(fila);
      if op = 3 then
        writeln(consultar(fila));
      if op = 4 then
        continuar := False;
    end;
End.
