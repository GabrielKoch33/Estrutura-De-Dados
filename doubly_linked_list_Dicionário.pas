Program dicionarioBastos ;

	type
 	tipo_inf = string;
  ptLista = ^lista;// permite apontar para palavras-chaves anteriores e posteriores
  ptDict = ^dicionario; //permite apontar de palavras-chaves para dicionário como de dict -> dict
  
    	  
		lista = record
				anterior: ptLista; 
    		palavra_chave: tipo_inf;  // CARRO - MELHOR (vamos deixar as palavras chaves em .upper()?)
    		ponteiro_dict: ptDict;
    		proximo: ptLista;
    		end;
							
	  dicionario = record
	  		ant_dicionario: ptDict;
    		verbete_PTBR: tipo_inf;
    		verbete_ING: tipo_inf;
    		prox_dicionario: ptDict;
    		end;
    
	  programa = record
		 		opcao: integer;
		 		palavra_chave: tipo_inf;  // palavra que o usuário vai informar, serve tanto para palavra chaves como verbetes
		 		palavra_ingles: tipo_inf;
		 		palavra_portugues: tipo_inf;
		 		ListaPalavrasChaves: ptLista;//ponteiro principal da lista
		 		adicionado : boolean;
		 		duplicada : boolean;
		 		contagem : integer;
		 		end;
		 
var
	 descritor: programa;

////////////////////////////////////////////////////////////	
procedure limpa_tela();
begin
	clrscr;
end;	 
////////////////////////////////////////////////////////////	 
procedure cria_lista_palavras(var ref_descritor: programa);
begin
		 ref_descritor.ListaPalavrasChaves:= nil;
end;
////////////////////////////////////////////////////////////
procedure ler_palavra_chave(var ref_descritor: programa);
begin
    writeln('Digite uma Palavra-Chave: ');
    readln(ref_descritor.palavra_chave);
    ref_descritor.palavra_chave := upcase(ref_descritor.palavra_chave);
end;

procedure ler_palavras_pt_ing(var ref_descritor: programa);
begin
		writeln('Digite a Palavra em Português: ');
		readln(ref_descritor.palavra_portugues);
		ref_descritor.palavra_portugues := upcase(ref_descritor.palavra_portugues);
		writeln('Digite a Palavra em Inglês: ');
		readln(ref_descritor.palavra_ingles);
		ref_descritor.palavra_ingles := upcase(ref_descritor.palavra_ingles);
end;
////////////////////////////////////////////////////////////
{function escrever_tudo(ref_descritor);
begin
end;}
////////////////////////////////////////////////////////////
{function buscar_traducao(ref_descritor);
begin                                   
end                                     }
////////////////////////////////////////////////////////////
procedure incluir_palavra_chave(var ref_descritor: programa);
var node,aux,aux2: ptLista;
begin
	ref_descritor.adicionado:= False;
	new(node);//node é igual a aux nos primeiros códigos, node = nó = estrutura basica do [anterior,dado,dict,prox]
	if node = nil then
	 		writeln('Memória Cheia')
	else
		begin
			ref_descritor.duplicada := False;
			aux:= ref_descritor.ListaPalavrasChaves;  
			while (aux <> nil) and (ref_descritor.duplicada = False) do
					begin
						if aux^.palavra_chave = ref_descritor.palavra_chave then
						begin
							writeln('A palavra ',ref_descritor.palavra_chave,' já está no dicionário! Duplicadas não são permitidas');
						  ref_descritor.duplicada := True;
						end;
						aux:= aux^.proximo;
					end;
			if (ref_descritor.ListaPalavrasChaves = nil) then // se for a primeira palavra-chave a ser incluida
				begin
 					node^.anterior := nil;
					node^.palavra_chave := ref_descritor.palavra_chave;
					node^.ponteiro_dict:= nil;
					node^.proximo:= nil;
					ref_descritor.ListaPalavrasChaves:= node;
					writeln('Palavra: "',ref_descritor.ListaPalavrasChaves^.palavra_chave,'" adicionada!'); 
					readkey;
					limpa_tela();
				end                                
			else
				begin
					if (ref_descritor.palavra_chave < ref_descritor.ListaPalavrasChaves^.palavra_chave) and (ref_descritor.duplicada = False) then // Esse IF verifica se a palavra a ser incluida é a menor de todas, até mesmo que a 1ª da lista
					begin 	
						node^.anterior := nil;         
						node^.palavra_chave := ref_descritor.palavra_chave;
						node^.ponteiro_dict:= nil;
						node^.proximo:= ref_descritor.ListaPalavrasChaves;
						ref_descritor.ListaPalavrasChaves^.anterior := node;
						ref_descritor.ListaPalavrasChaves := node;	
						writeln('Palavra: "',ref_descritor.ListaPalavrasChaves^.palavra_chave,'" adicionada!'); 
						readkey;	
						limpa_tela()
					end
					else if (ref_descritor.duplicada = False) then // agora é onde iremos perocorrer os nós até achar uma posição que se encaixe
						begin
						  aux:= ref_descritor.ListaPalavrasChaves; // o papel de aux será armazenar o endereço do nó ANTERIOR a nova inserção
						  aux2:= ref_descritor.ListaPalavrasChaves; // o papel de aux2 é armazenar o endereço do nó POSTERIOR a nova inserção
							while (aux^.palavra_chave < ref_descritor.palavra_chave) and (aux2^.proximo <> nil) and (ref_descritor.adicionado = False) do
							begin                                                              
								   aux2:= aux2^.proximo;//antes de parar o while, e caso a posição que será inserida for a última, então aux2 parará no último nó criado, tornando false a condição do while e saindo do loop
								   if aux2^.palavra_chave >= ref_descritor.palavra_chave then // se a palavra que aux2 estiver apontado for maior que a inserção, então aux1 ainda estará na anterior a essa, permitindo a conexão
								   begin                                    
								   		 node^.anterior := aux;
								   		 node^.palavra_chave:=ref_descritor.palavra_chave;
								   		 node^.ponteiro_dict:= nil;
								   		 node^.proximo:= aux2;
								   		 aux2^.anterior:= node;
								   		 aux^.proximo:=node;
								   		 writeln('Palavra: "',node^.palavra_chave,'" adicionada!');
		 									 ref_descritor.adicionado := True; //em um caso muito específico onde a palavra inserida é entre a ultima e penúltima, ocorre um bug que a palavra é adicionada aqui e no if de baixo, substituindo a ultima palavra 
											 readkey;
											 limpa_tela();
								   end
								   else // caso não encontre uma posição intermediária para inserir, então aux += aux
								   		aux:= aux^.proximo;
							end;
						if (aux2^.proximo = nil) and (ref_descritor.adicionado = False) and (ref_descritor.duplicada = False) then// caso aux2 pare na última posição: node é 'populado' e ligado a lista como sendo o ultimo
							begin
								node^.anterior := aux2;
								node^.palavra_chave := ref_descritor.palavra_chave;
								node^.ponteiro_dict:= nil;                                        
								node^.proximo:=nil;
								aux2^.proximo:= node;
								writeln('Palavra: "',node^.palavra_chave,'" adicionada!'); 
								readkey;
								limpa_tela();
							end
					end;
				end;
		end;
end;

//procedure remover_palavra_chave()//2
procedure incluir_palavra_no_dicionario(var ref_descritor: programa); // a ideia é que ao inserir a palavra o programa já aloque ela na palavra correta automaticamente
var aux: ptLista;
var node, aux2: ptDict;
begin
		new(node);
		ref_descritor.adicionado := False;
		aux := ref_descritor.ListaPalavrasChaves;
		
	  while (aux^.palavra_chave < ref_descritor.palavra_portugues) and (aux^.proximo <> nil) do // faz o aux parar exatamente na palavra chave que queremos inserir o verbete
	  begin	
			aux := aux^.proximo;
		end;
		
		//se estivermos na última posição e ainda sim o último elemento for uma Palavra Chave menor que a que queremos incluir, então não existe palavras chaves compativel
	  if (aux^.proximo = nil) and (aux^.palavra_chave < ref_descritor.palavra_portugues) then  
			begin
				writeln('Não existe palavra-chave para suportar este verbete, crie uma nova Palavra-Chave maior que ',aux^.palavra_chave);	//talvez chamar função de criar a palavra chave
			end	
			
		else // em qualquer outra posição de inserção, esse Else ocorre
			begin
			    // só executa esse if/while caso EXISTAM palavras dentro de um dicionário
					ref_descritor.duplicada := False;		
					if aux^.ponteiro_dict <> nil then
						begin
							aux2 := aux^.ponteiro_dict;
							while (aux2 <> nil) and (ref_descritor.duplicada = False) do
							begin
								if ref_descritor.palavra_portugues = aux2^.verbete_PTBR then // se a palavra que queremos inserir for igual à algum verbete anteriormente adicionado, então duplicados não permitidos
									begin
									    writeln('A palavra ',ref_descritor.palavra_portugues,' já está no dicionário! Duplicadas não são permitidas');
									    ref_descritor.duplicada := True;
									end;
								aux2 := aux2^.prox_dicionario;
							end;
						end;
						
					// caso não existam duplicadas: 	
					if ref_descritor.duplicada = False then
					begin
				    if node = nil then
				    	writeln('Memória Cheia!')
				    	
				    else if (aux^.ponteiro_dict = nil) then // se essa for a primeira palavra a ser incluido então esse Else if ocorre
				    	begin
				    		node^.ant_dicionario := nil;    
				    		node^.verbete_PTBR := ref_descritor.palavra_portugues;
				    		node^.verbete_ING := ref_descritor.palavra_ingles;
				    		node^.prox_dicionario := nil;
				    		aux^.ponteiro_dict := node;
				    	end
				    	
				    else // caso já haja palavra já associadas é palavra chave, esse Else ocorre
				      begin  
							   aux2:= aux^.ponteiro_dict;
				      	   if (ref_descritor.palavra_portugues < aux2^.verbete_PTBR) then// caso for menor que a primeira
				      	   		begin
				      		   			                                                 
				      	   	  	node^.ant_dicionario := nil;  
				      	   	  	node^.verbete_PTBR := ref_descritor.palavra_portugues;
				      	   	  	node^.verbete_ING := ref_descritor.palavra_ingles;
				      	   	  	node^.prox_dicionario := aux2;
				      	   	  	
				      	   	  	aux2^.ant_dicionario:= node;
				      	   	  	aux^.ponteiro_dict:=node;
				      	   		end
				      	   else  // esse Else vai tratar de encontrar a posição correta e inserir
				      	   		begin
				      	   		    /// percorre as palavras cadastradas a fim de encontrar a posição de inserção
				      	   		    
				      	   		end;
				      end;
			    end;
			end;
				
			
end;
//procedure remover_palavra_do_dicionario()//4
//function escrever_dicionario()   //6

function consultar_palavra_chave(ref_descritor: programa): integer;//5
var i   : integer;
var aux : ptLista;
begin
    if (ref_descritor.ListaPalavrasChaves = nil) then
    begin
        i := 0;
        writeln('Dicionário Vazio, nada para exibir');
    end
    else
    begin
        aux := ref_descritor.ListaPalavrasChaves;
        i   := 0;
        while aux^.proximo <> nil do
        begin
            i := i + 1; 
            writeln(i, ' - ', aux^.palavra_chave);
            aux := aux^.proximo
        end;
        i:= i + 1;
        writeln(i,' - ',aux^.palavra_chave);
    end;
    consultar_palavra_chave := i;
end;

////////////////////////////////////////////////////////////
Begin        {FAZER INICIO E FIM DA LISTA, PARA QUE POSSA SER PERCORRIDA DE TRÁS PARA FRENTE}
	
	cria_lista_palavras(descritor);                           
	descritor.opcao := 10;
	while descritor.opcao <> 0 do
	begin
	  writeln('1 - Incluir Palavra-Chave'); 				      // 1 //FEITO  
		writeln('2 - Remover Palavra-Chave');               // 7
		writeln('3 - Incluir Palavra no Dicionário');       // 2 //EM PROGRESSO
		writeln('4 - Remover Palavra do Dicionário');       // 3 //
		writeln('5 - Escrever Todas as Palavras de Todos os Dicionário'); // 6 
		writeln('6 - Escrever Dicionário de sua Escolha');  // 4       Tornar a 5 e 6 uma unica função?
		writeln('7 - Buscar Tradução');                     // 5
		writeln('8 - Consultar Palavras-Chaves'); 
		writeln('0 - Sair');		
		writeln('Escolha uma das opções a cima: ');
		readln(descritor.opcao);                    
		
		if descritor.opcao = 1 then // incluir palavra chave OK
		begin
			limpa_tela();
			ler_palavra_chave(descritor);
			limpa_tela();
			incluir_palavra_chave(descritor);
		end
		 
		else if descritor.opcao = 2 then  // remover palavra chave (transferir palavras desse dicionário para o dicionário anterior)
		begin
			limpa_tela();
			ler_palavra_chave(descritor);
			limpa_tela();
		//remover_palavra_chave();
		end	
			
		else if descritor.opcao = 3 then   // incluir no dicionário automáticamente
		begin
			limpa_tela();
			ler_palavras_pt_ing(descritor);
			limpa_tela();
			incluir_palavra_no_dicionario(descritor);
		end
		
		else if descritor.opcao = 4 then   // remover palavra do dicionário
		begin
			limpa_tela();        
			ler_palavras_pt_ing(descritor);
			limpa_tela();
		//remover_palavra_do_dicionario(descritor);
		end
		
		else if descritor.opcao = 5 then // escrever todos os dicionários
		begin
		{	limpa_tela();
			ler_palavra(descritor);
			limpa_tela();
			escrever_tudo(descritor);}
		end
			
		else if descritor.opcao = 6 then   // escrever dicionário escolhido pelo usuário
		begin
			limpa_tela();
			ler_palavra_chave(descritor);
			limpa_tela();
		//escrever_dicionario_escolha(descritor);
		end
		
		else if descritor.opcao = 7 then    //  escolher palavra e trazer tradução
		begin
			limpa_tela();
		//buscar_traducao(descritor);
		end
				
		else if descritor.opcao = 8 then    
		begin
			limpa_tela();
			descritor.contagem := consultar_palavra_chave(descritor);
			writeln('Quantidade de Palavras-Chaves: ',descritor.contagem);
			readkey;
			limpa_tela()
		end;
		
	end;
		
End.
{// Aqui vão ser inseridas todas, ou as mais importantes, variaveis, assim como uma explicação do que ela faz: 
-
-
//}
{
//O protótipo deve ter as opções: incluir a palavra-chave, incluir no dicionário, remover do dicionário, consultar, escrever todo dicionário//
-O programa deve permitir cadastrar PALAVRAS-CHAVES (PC)
-Ao criar uma palavra-chave nova intermediária de duas já existêntes (ex: [D]-*[G]*-[M]), teremos que transferir as possíveis palavras D < G < M para que estão em [M] para [G]
-Não será possível cadastrar VERBETES se não houver PALAVRAS-CHAVES
-Se tentar cadastrar um VERBETE que for MAIOR que as todas as PALAVRAS-CHAVES existêntes, não será possível
--Ex: última PC = ônibus, verbete = rato --> Erro --> Logo: criar nova PC
-Ao adicionar novo verbete no dicionário, o programa vai percorrer a lista principal, identificar a PC, acessar o dicionário, percorrer o dict, e inserir na devida posição
}
