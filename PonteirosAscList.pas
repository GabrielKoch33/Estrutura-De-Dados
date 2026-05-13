Program Pzim ;

type
    tipo_inf = integer;
    ponteiro = ^elemento;
    
    elemento  = record
        dado: tipo_inf;
        prox: ponteiro
    end;
   
  var
  pilha: ponteiro;
  num, totnumeros: tipo_inf;
  op: byte;
  continuar: boolean;
  
   procedure create_pilha_nill (var pilhaE : ponteiro);
    begin
        pilhaE:= nil;      //inicia fila como NULL; não aponta para nada na memória
    end;    
    
    procedure ler_num (var number: tipo_inf);
    begin
      writeln('digite um valor: ');
      readln(number);
    end;
    
    procedure incluir(var pilhaE: ponteiro; number: tipo_inf);
    var node: ponteiro;
    var aux: ponteiro;
    begin
        new(node);
        if (node = nil) then
            writeln('MEMÓRIA CHEIA')
        else
            begin
                if (pilhaE = nil) then
                    begin
                    node^.dado := number;
                    node^.prox := pilhaE;
                    pilhaE:= node;  
                    end
                else
                begin
                    if number < pilhaE^.dado then
                    begin
                       aux:= pilhaE;
                       node^.dado:= number;
                       node^.prox:= pilhaE^.dado;
                       pilhaE:= node;
                    end;
                    else
                    Begin
                        aux:= pilhaE;
                        while aux^.prox < number do
                        Begin
                            aux := aux^.prox
                        end;
                        node^.dado := number;
                        node^.prox := aux^.prox;
                        aux^.prox := node;
                    end;
                end;
            end;
    end;

    procedure remover (var pilhaE: ponteiro);
    var aux: ponteiro;
    var num_remove: tipo_inf;
    begin
    writeln('escolha um dos numeros presentes para remover: ')
    readln(num_remove);
       if (pilhaE = nil) then
            writeln('Fila Vazia, Nada para remover')
       else
       begin
           if num_remove = pilhaE^.dado then
            begin
                aux:= pilhaE;
                pilhaE := aux^.prox;
                dispose(aux);
            end;
           else
           begin
               aux:= pilhaE;
               while num_remove <> aux^.dado do
               begin
                 aux := aux^.prox
               end
               while aux^.prox <> nil do
                aux^.dado:= aux
               
                while aux^.prox <> nil do
                begin                aux:= aux^.prox
                end;
                writeln('Foi removido o elemento ',aux^.dado,'!');
                dispose(aux);
                    
           end;
        end;
    end;
    
    function consultar(pilhaE: ponteiro):tipo_inf;
    var i: integer;
    var aux: ponteiro;
    begin
        if (pilhaE = nil) then
        begin
            i:= 0;
            writeln('Pilha Vazia, nada para exibir');
        end
        else
        begin
            aux:= pilhaE;
            i:= 0;
            while aux^.prox <> nil do
            begin
                i:= i + 1; 
                writeln(i,' - ', aux^.dado);
                aux:= aux^.prox
            end;
        end;
        
        consultar := i;
    end;
 
Begin
        continuar := True;
        num:= 0;
        
        create_pilha_nill(pilha);
        while continuar = True do
        begin
            writeln('1 - INCLUIR');
            writeln('2 - REMOVER ULTIMO');
            writeln('3 - CONSULTAR');
            writeln('4 - SAIR');
            writeln(' oque deseja fazer?');
            readln(op);
            if op = 1 then
            begin
                ler_num(num);
                incluir(pilha,num);
            end;
            if op = 2 then
                remover(pilha);
            if op = 3 then
                writeln(consultar(pilha));
            if op = 4 then
                continuar := False;
                
        end;
End.
