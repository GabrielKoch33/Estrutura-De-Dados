Program Pzim;

type
  tipo_inf = integer;
  ponteiro = ^elemento;
  elemento = record
    dado: tipo_inf;
    prox: ponteiro
  end;

var
  pilha     : ponteiro;
  num       : tipo_inf;
  op        : byte;
  continuar : boolean;

procedure create_pilha_nill(var pilhaE: ponteiro);
begin
  pilhaE := nil;
end;

procedure ler_num(var number: tipo_inf);  // << var corrigido aqui
begin
  writeln('Digite um valor: ');
  readln(number);
end;

procedure empilhar(var pilhaE: ponteiro; number: tipo_inf);
var node: ponteiro;
begin
  new(node);
  if (node = nil) then
    writeln('MEMÓRIA CHEIA')
  else
    begin
      node^.dado := number;
      node^.prox := pilhaE;  // novo nó aponta para quem era o topo
      pilhaE     := node;    // novo nó vira o topo
    end;
end;

procedure desempilhar(var pilhaE: ponteiro);
var aux: ponteiro;
begin
  if (pilhaE = nil) then
    writeln('Pilha Vazia, nada para remover')
  else
    begin
      aux    := pilhaE;
      pilhaE := aux^.prox;
      writeln('Foi removido o elemento ', aux^.dado, '!');
      dispose(aux);
    end;
end;

function consultar(pilhaE: ponteiro): tipo_inf;
var
  i   : integer;
  aux : ponteiro;
begin
  if (pilhaE = nil) then
    begin
      i := 0;
      writeln('Pilha Vazia, nada para exibir');
    end
  else
    begin
      aux := pilhaE;
      i   := 0;
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
  num       := 0;
  create_pilha_nill(pilha);

  while continuar = True do
    begin
      writeln('1 - EMPILHAR');
      writeln('2 - DESEMPILHAR');
      writeln('3 - CONSULTAR');
      writeln('4 - SAIR');
      writeln('O que deseja fazer?');
      readln(op);

      if op = 1 then
        begin
          ler_num(num);
          empilhar(pilha, num);
        end;
      if op = 2 then
        desempilhar(pilha);
      if op = 3 then
        writeln(consultar(pilha));
      if op = 4 then
        continuar := False;
    end;
End.
