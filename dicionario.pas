Program dicionarioBastos ;

	    type
        tipo_inf 	= string;
        ptLista 	= ^lista;// permite apontar para palavras-chaves anteriores e posteriores
        ptDict 		= ^dicionario; //permite apontar de palavras-chaves para dicionário como de dict -> dict
  				  
		lista = record
			anterior			: ptLista; 
    		palavra_chave		: tipo_inf;  // CARRO - MELHOR (vamos deixar as palavras chaves em .upper()?)
    		ponteiro_dict		: ptDict;
    		proximo				: ptLista;
    		end;
							
	  dicionario = record
    		verbete_PTBR		: tipo_inf;
    		verbete_ING			: tipo_inf;
    		prox_dicionario		: ptDict;
    		end;
    
	  programa = record
		 	opcao				: integer;
		 	palavra_chave_user	: tipo_inf;// palavra que o usuário vai informar
		 	palavra_ingles		: tipo_inf;
		 	palavra_portugues	: tipo_inf;
		 	ListaPalavrasChaves : ptLista;//ponteiro principal da lista
		 	adicionado 			: boolean;
		 	encontrada			: boolean;//sinceramente essa var nem precisava existir, mas vou criar para tornar "indentificavel" seu uso, mas no lugar dela podia ser qualquer outra booleana
		 	duplicada 			: boolean;
		 	contagem 			: integer;
			head_PalavrasChaves	: ptLista;
			tail_PalavrasChaves	: ptLista;
		 	end;
{COISAS A FAZER: | PC = Palavra Chave
- A Engenharia reversa deve ser feita na remoção de PCs tbm, onde vamos remover a PC e a anterior deve receber os Verbetes maiores, os verbetes vão ser inseridos no ultimo nó da PC menor.
- Na função de escrever todos os dicionários: User seleciona ordem ascendente [A] e decrescente [D], dependendo da escolha, basta iniciar por HEAD (marca início) ou TAIL (marca o último elemento)
}	 
var
	 descritor: programa;

////////////////////////////////////////////////////////////	
procedure limpa_tela();
begin
	readkey;
	clrscr;
end;	 
////////////////////////////////////////////////////////////	 
procedure cria_lista_palavras(var ref_descritor: programa);
begin
		 ref_descritor.ListaPalavrasChaves	:= nil;
		 ref_descritor.head_PalavrasChaves	:= nil;
		 ref_descritor.tail_PalavrasChaves	:= nil;
end;
////////////////////////////////////////////////////////////
procedure ler_palavra_chave(var ref_descritor: programa);
begin
	writeln('=====================================================');	
    writeln('Digite uma Palavra-Chave: ');
    readln(ref_descritor.palavra_chave_user);
    ref_descritor.palavra_chave_user := upcase(ref_descritor.palavra_chave_user);
end;

procedure ler_palavras_pt_ing(var ref_descritor: programa);
begin
		writeln('=====================================================');	
		writeln('Digite o Verbete em Português: ');
		readln(ref_descritor.palavra_portugues);
		ref_descritor.palavra_portugues := upcase(ref_descritor.palavra_portugues);
		writeln('=====================================================');	
		writeln('Digite o Verbete em Inglês: ');
		readln(ref_descritor.palavra_ingles);
		writeln('=====================================================');	
		ref_descritor.palavra_ingles := upcase(ref_descritor.palavra_ingles);
end;
////////////////////////////////////////////////////////////
function verifica_duplicada_no_dict(ref2_descritor: programa; ref_aux2: ptDict):boolean; 
begin
		while (ref_aux2 <> nil) and (ref2_descritor.duplicada = False) do
		begin
  			if ref2_descritor.palavra_portugues = ref_aux2^.verbete_PTBR then // se a palavra que queremos inserir for igual à algum verbete anteriormente adicionado, então duplicados não permitidos
				begin
					  ref2_descritor.duplicada := True;
				end;
			ref_aux2 := ref_aux2^.prox_dicionario;
		end;
verifica_duplicada_no_dict:= ref2_descritor.duplicada;
end;
////////////////////////////////////////////////////////////
function verifca_duplicada_palavra_chave(ref2_descritor: programa; ref_aux: ptLista): boolean;
begin
    while (ref_aux <> nil) and (ref2_descritor.duplicada = False) do
    	begin
			if ref_aux^.palavra_chave = ref2_descritor.palavra_chave_user then
			    begin
				    writeln('A palavra-Chave: "',ref2_descritor.palavra_chave_user,'" já está no dicionário! Duplicadas não são permitidas');
				    limpa_tela();
			        ref2_descritor.duplicada := True;
			    end;
		    ref_aux:= ref_aux^.proximo;
	    end;
    verifca_duplicada_palavra_chave := ref2_descritor.duplicada;
end;
////////////////////////////////////////////////////////////
procedure transferir_verbetes( var pc_doadora: ptLista; var node_receptora: ptLista; palavra_split: tipo_inf); 
//palavra split seria a PC nova que o user informou
var aux4, aux3: ptDict;
begin 
    aux4 := nil;
    aux3 := pc_doadora^.ponteiro_dict;

    while (aux3 <> nil) and (aux3^.verbete_PTBR <= palavra_split) do
    begin
       aux4 := aux3;
       aux3 := aux3^.prox_dicionario;
    end; 

    if aux4 = nil then  // aux4 só será nil quando nenhuma palavra do head for menor que node
    begin
        node_receptora^.ponteiro_dict := nil;// então node·pt_dict passa para NIL ao invés de apontar para o dict de Head
    end
    else
        begin
            aux4^.prox_dicionario := nil; // corta o link entre as palavras que vão e as que ficam
        end;
    pc_doadora^.ponteiro_dict := aux3; // conecta o head as palavras que não foram transferidas
end;
////////////////////////////////////////////////////////////

function escreve_itens(ref_aux2: ptDict; ref_i: integer): integer;
begin                                   
while ref_aux2^.prox_dicionario <> nil do
	  begin
	     writeln(ref_i,' - Português: ', ref_aux2^.verbete_PTBR,' | Inglês: ',ref_aux2^.verbete_ING);    
	     ref_aux2 := ref_aux2^.prox_dicionario;
	     ref_i := ref_i + 1; 
	  end;
	  writeln(ref_i,' - Português: ', ref_aux2^.verbete_PTBR,' | Inglês: ',ref_aux2^.verbete_ING);
	  writeln('=====================================================');	
	  escreve_itens := ref_i;
end;
////////////////////////////////////////////////////////////
procedure incluir_palavra_chave(var ref_descritor: programa);
var node,aux,aux2: ptLista;
var aux3, aux4: ptDict;
begin
	new(node);//node é igual a aux nos primeiros códigos, node = nó = estrutura basica do [anterior,dado,dict,prox]
	if node = nil then
		begin
	 		writeln('Memória Cheia');
	 		limpa_tela();
	 	end
	else
		begin;
			if (ref_descritor.head_PalavrasChaves = nil) then // se for a primeira palavra-chave a ser incluida
				begin
 					node^.anterior 											 := nil;
					node^.palavra_chave									 := ref_descritor.palavra_chave_user;
					node^.ponteiro_dict									 := nil;
					node^.proximo												 := nil;
				    ref_descritor.head_PalavrasChaves		 := node; //inicio aponta para o 1º inserido
                    ref_descritor.tail_PalavrasChaves		 := node; //fim também, afinal o unico elemento é o primeiro e o ultimo 
					 
					writeln('Palavra-Chave: "',node^.palavra_chave,'" adicionada!'); 
					limpa_tela();
				end                                
			else // possui elementos                                                                                                                                                        
			   // verfica duplicatas quando se tem pelo menos um elemento //TALVEZ TRANSFORMAR EM FUNÇÃO?
				begin
					ref_descritor.duplicada := False;
					aux:= ref_descritor.head_PalavrasChaves; 

                    if verifca_duplicada_palavra_chave(ref_descritor, aux) = True then
                        writeln('A palavra-Chave: "',ref_descritor.palavra_chave_user,'" já está no dicionário! Duplicadas não são permitidas')
					else
                    begin// tudo aqui embaixo só será executado se NÃO houver duplicidade
                        if (ref_descritor.palavra_chave_user < ref_descritor.head_PalavrasChaves^.palavra_chave) then 
                            begin// verifica se a palavra a ser incluida é a menor de todas, até mesmo que a 1ª da lista 	
                                
                                node^.anterior                              := nil;                        
                                node^.palavra_chave 						:= ref_descritor.palavra_chave_user;
                                node^.ponteiro_dict							:= ref_descritor.head_PalavrasChaves^.ponteiro_dict;
                                node^.proximo								:= ref_descritor.head_PalavrasChaves;
                                ref_descritor.head_PalavrasChaves^.anterior := node;
                                
                                transferir_verbetes(ref_descritor.head_PalavrasChaves, node, ref_descritor.palavra_chave_user);

                                ref_descritor.head_PalavrasChaves := node;

                                if node^.ponteiro_dict = nil then
                                    writeln('Palavra-Chave: "',node^.palavra_chave,'" adicionada!')
                                else
                                    writeln('Palavra-Chave: "',node^.palavra_chave,'" adicionada e os devidos verbetes foram migrados!'); 	
                                limpa_tela();

                            end
                        
                        else if (ref_descritor.palavra_chave_user > ref_descritor.tail_PalavrasChaves^.palavra_chave) then
                            begin   // verifica se a palavra é a maior de todas
                            
                                node^.anterior                              := ref_descritor.tail_PalavrasChaves;                        
                                node^.palavra_chave 						:= ref_descritor.palavra_chave_user;
                                node^.ponteiro_dict							:= nil;
                                node^.proximo								:= nil;
                                ref_descritor.tail_PalavrasChaves^.proximo  := node;
                                ref_descritor.tail_PalavrasChaves 			:= node;
                                    
                                writeln('Palavra-Chave: "',node^.palavra_chave,'" adicionada!'); 	
                                limpa_tela();	
                            end
                            
                        else// se não é a menor e nem a maior, então percorre
                            begin
                                aux:= ref_descritor.head_PalavrasChaves;
                                
                                while (aux^.palavra_chave < ref_descritor.palavra_chave_user) and (aux^.proximo <> nil) do
                                    aux := aux^.proximo; // aux para um Nó na frente do que se deseja incluir
                                aux2 					:= aux^.anterior; // aux2 recebe um nó antes do que aux

                                node^.anterior      	:= aux2;
                                node^.palavra_chave 	:= ref_descritor.palavra_chave_user;
                                node^.ponteiro_dict 	:= aux^.ponteiro_dict;
                                node^.proximo       	:= aux;
                                aux2^.proximo       	:= node;
                                aux^.anterior       	:= node;

                                transferir_verbetes(aux, node, ref_descritor.palavra_chave_user);

                                if node^.ponteiro_dict = nil then
                                    writeln('Palavra-Chave: "',node^.palavra_chave,'" adicionada!')
                                else
                                    writeln('Palavra-Chave: "',node^.palavra_chave,'" adicionada e os devidos verbetes foram migrados!'); 	
                                limpa_tela();
                            end;
                    end;
                end;
		end;
end;

//procedure remover_palavra_chave()//2

procedure incluir_palavra_no_dicionario(var ref_descritor: programa); // a ideia é que ao inserir a palavra o programa já aloque ela na palavra correta automaticamente
var aux: ptLista;
var node, aux2, aux3: ptDict;
begin
		if ref_descritor.head_PalavrasChaves = nil then
		begin
			writeln('Nenhuma Palavra-Chave foi cadastrada! Por favor cadastre Palavras-Chaves para então criar dicionários/verbetes específicos');
			limpa_tela();
		end
		else
		begin
			ler_palavras_pt_ing(descritor);
		//se estivermos na última posição e ainda sim o último elemento for uma Palavra Chave menor que a que queremos incluir, então não existe palavras chaves compativel
			if (ref_descritor.tail_PalavrasChaves^.palavra_chave < ref_descritor.palavra_portugues) then  
			begin
				writeln('Não existe palavra-chave para suportar este Verbete, crie uma nova Palavra-Chave maior que ',ref_descritor.tail_PalavrasChaves^.palavra_chave);
				limpa_tela();
			end
				
			else // Se for possível adicionar o verbete, então esse else ocorre
				begin
					new(node);
	        if node = nil then
	        begin
						writeln('Memória Cheia!');
						limpa_tela();
					end
					else
					begin
						// If para adicionar a palavra/pt/ing no primeiro elemento
						///////////////////////////////////////////////////
						if ref_descritor.head_PalavrasChaves^.palavra_chave > ref_descritor.palavra_portugues then
						begin
							 aux := ref_descritor.head_PalavrasChaves;
							 if aux^.ponteiro_dict = nil then // não existem palavras, logo n checa duplicada
							 begin  
									 	node^.verbete_PTBR 				:= ref_descritor.palavra_portugues;
									  node^.verbete_ING 				:= ref_descritor.palavra_ingles;
									  node^.prox_dicionario 		:= nil;
									  aux^.ponteiro_dict 				:= node;
									  writeln('O verbete: "', ref_descritor.palavra_portugues,'" | "',ref_descritor.palavra_ingles,'" foi adicionado à Palavra-Chave: "', ref_descritor.head_PalavrasChaves^.palavra_chave);
										limpa_tela();
							 end
						   else// se possuir elementos, então verifica duplicadas
							 begin
									aux2 := aux^.ponteiro_dict;				
									if verifica_duplicada_no_dict(ref_descritor, aux2) = True then
									begin
										writeln('O Verbete ',ref_descritor.palavra_portugues,' já está no dicionário! Duplicadas não são permitidas!');
										limpa_tela();
									end
									else
										begin
											ref_descritor.adicionado := False;
											aux3 := aux2;
											while (aux3^.prox_dicionario <> nil) and ( aux3^.verbete_PTBR < ref_descritor.palavra_portugues ) do
											begin
											 	aux3:= aux3^.prox_dicionario;
											    if aux3^.verbete_PTBR > ref_descritor.palavra_portugues then //verifica as posições a fim de encontrar ANTERIOR(aux2) e POSTERIOR(aux3)
											 	begin
											  		node^.verbete_PTBR 		   := ref_descritor.palavra_portugues;
									  				node^.verbete_ING 		   := ref_descritor.palavra_ingles;
											  		node^.prox_dicionario 	 := aux3;
											  		aux2^.prox_dicionario 	 := node;
											  		ref_descritor.adicionado := True;
	 									  			 writeln('O verbete: "', ref_descritor.palavra_portugues,'" | "',ref_descritor.palavra_ingles,'" foi adicionado à Palavra-Chave: "', ref_descritor.head_PalavrasChaves^.palavra_chave);
										            limpa_tela();
											  	end
											    else
											 	    aux2:= aux2^.prox_dicionario;
                                            end;
											if (aux3^.prox_dicionario = nil) and (ref_descritor.adicionado = False) then // caso seja o último elemento
											 	begin
											 		  node^.verbete_PTBR 		:= ref_descritor.palavra_portugues;
									  				node^.verbete_ING 		:= ref_descritor.palavra_ingles;
											  		node^.prox_dicionario := nil;
											  		aux3^.prox_dicionario := node;
											  		writeln('O verbete: "', ref_descritor.palavra_portugues,'" | "',ref_descritor.palavra_ingles,'" foi adicionado à Palavra-Chave: "', ref_descritor.head_PalavrasChaves^.palavra_chave);
										        limpa_tela();
											 	end;	 
										end;	
						   end;
						end
				///////////////////////////////////////////////////
				// else if para adicionar no ultimo elemento (tail)
        else if (ref_descritor.tail_PalavrasChaves^.palavra_chave > ref_descritor.palavra_portugues) and
                (ref_descritor.tail_PalavrasChaves^.anterior^.palavra_chave < ref_descritor.palavra_portugues) then
        begin
            aux := ref_descritor.tail_PalavrasChaves;
            if aux^.ponteiro_dict = nil then
            begin
                node^.verbete_PTBR     := ref_descritor.palavra_portugues;
                node^.verbete_ING      := ref_descritor.palavra_ingles;
                node^.prox_dicionario  := nil;
                aux^.ponteiro_dict     := node;
                writeln('O verbete: "', ref_descritor.palavra_portugues,'" | "',ref_descritor.palavra_ingles,'" foi adicionado à Palavra-Chave: "', ref_descritor.tail_PalavrasChaves^.palavra_chave);
								limpa_tela();
            end
            else // se a última PC possuir elementos: 
            begin
                aux2 := aux^.ponteiro_dict;
                if verifica_duplicada_no_dict(ref_descritor, aux2) = True then
                begin
                    writeln('O Verbete ', ref_descritor.palavra_portugues,' já está no dicionário! Duplicadas não são permitidas!');
                    limpa_tela();
                end
                else 
                begin
                	ref_descritor.adicionado := False;
									aux3 := aux2;
									while (aux3^.prox_dicionario <> nil) and ( aux3^.verbete_PTBR < ref_descritor.palavra_portugues ) do
										begin
											 aux3:= aux3^.prox_dicionario;
											 if aux3^.verbete_PTBR > ref_descritor.palavra_portugues then //verifica as posições a fim de encontrar ANTERIOR(aux2) e POSTERIOR(aux3)
											 		begin
											  			node^.verbete_PTBR 		   := ref_descritor.palavra_portugues;
									  					node^.verbete_ING 		   := ref_descritor.palavra_ingles;
											  			node^.prox_dicionario 	 := aux3;
											  			aux2^.prox_dicionario 	 := node;
											  			ref_descritor.adicionado := True;
											  			writeln('O verbete: "', ref_descritor.palavra_portugues,'" | "',ref_descritor.palavra_ingles,'" foi adicionado à Palavra-Chave: "', ref_descritor.tail_PalavrasChaves^.palavra_chave);
									 	          limpa_tela();
											  	end
											 	else
											 		aux2:= aux2^.prox_dicionario;
										end;
											if (aux3^.prox_dicionario = nil) and (ref_descritor.adicionado = False) then // caso seja o último elemento
												begin
													  node^.verbete_PTBR 		:= ref_descritor.palavra_portugues;
									  				node^.verbete_ING 		:= ref_descritor.palavra_ingles;
											  		node^.prox_dicionario := nil;
											  		aux3^.prox_dicionario := node;
											  		writeln('O verbete: "', ref_descritor.palavra_portugues,'" | "',ref_descritor.palavra_ingles,'" foi adicionado à Palavra-Chave: "', ref_descritor.tail_PalavrasChaves^.palavra_chave);
									 					limpa_tela();
												end;
								end;
            end;
        end
        else // procura a posição qualquer, afinal ñ esta em head nem em tail
					begin
							aux:= ref_descritor.head_PalavrasChaves^.proximo;
						  while (aux^.palavra_chave < ref_descritor.palavra_portugues) and (aux^.proximo <> nil) do 
				  		begin 	
								aux := aux^.proximo; // aux é setado na PC correta
							end;
							
							if aux^.ponteiro_dict = nil then
          		begin
                node^.verbete_PTBR     := ref_descritor.palavra_portugues;
                node^.verbete_ING      := ref_descritor.palavra_ingles;
                node^.prox_dicionario  := nil;
                aux^.ponteiro_dict     := node;
                writeln('O verbete: "', ref_descritor.palavra_portugues,'" | "',ref_descritor.palavra_ingles,'" foi adicionado à Palavra-Chave: "', aux^.palavra_chave);
                limpa_tela();
            	end
            	else
            	begin
            		aux2 := aux^.ponteiro_dict;
            		if verifica_duplicada_no_dict(ref_descritor, aux2) then
            		begin
                    writeln('O Verbete ', ref_descritor.palavra_portugues, ' já está no dicionário! Duplicadas não são permitidas!');
                    limpa_tela();
                end
                else
                begin
                  ref_descritor.adicionado := False;
									aux3 := aux2;
									while (aux3^.prox_dicionario <> nil) and ( aux3^.verbete_PTBR < ref_descritor.palavra_portugues ) do
										begin
											 aux3:= aux3^.prox_dicionario;
											 if aux3^.verbete_PTBR > ref_descritor.palavra_portugues then //verifica as posições a fim de encontrar ANTERIOR(aux2) e POSTERIOR(aux3)
											 		begin
											  			node^.verbete_PTBR 		   := ref_descritor.palavra_portugues;
									  					node^.verbete_ING 		   := ref_descritor.palavra_ingles;
											  			node^.prox_dicionario 	 := aux3;
											  			aux2^.prox_dicionario 	 := node;
											  			ref_descritor.adicionado := True;
											  			writeln('O verbete: "', ref_descritor.palavra_portugues,'" | "',ref_descritor.palavra_ingles,'" foi adicionado à Palavra-Chave: "', aux^.palavra_chave);
											  			limpa_tela();
											  	end
											 	else
											 		aux2:= aux2^.prox_dicionario;
										end;
											if (aux3^.prox_dicionario = nil) and (ref_descritor.adicionado = False) then // caso seja o último elemento
												begin
													  node^.verbete_PTBR 		:= ref_descritor.palavra_portugues;
									  				node^.verbete_ING 		:= ref_descritor.palavra_ingles;
											  		node^.prox_dicionario := nil;
											  		aux3^.prox_dicionario := node;
											  		writeln('O verbete: "', ref_descritor.palavra_portugues,'" | "',ref_descritor.palavra_ingles,'" foi adicionado à Palavra-Chave: "', aux^.palavra_chave);
											  		limpa_tela();
												end;
									 end;
            		end;
						end;
				end;
    end; 
  end;
end;
   
procedure remover_palavra_do_dicionario(var ref_descritor: programa);
var aux: ptLista;
var node, aux2, aux3: ptDict;
begin
end;

////////////////////////////////////////////////////////////
{function escrever_tudo(ref_descritor);
begin
end;}
////////////////////////////////////////////////////////////
function escrever_dicionario_escolhido(ref_descritor: programa): integer;
var aux: ptLista;
var aux2, aux3: ptDict;
var i: integer;
begin
   if (ref_descritor.head_PalavrasChaves = nil) then
   begin                                                         
      i := 0;
      writeln('=====================================================');	
      writeln('Lista de Palavras-Chaves vazia. Nada para exibir :( ');
   end
   
   else
   begin
    	ler_palavra_chave(descritor);   // User informa PC
    	ref_descritor.encontrada := False;      
    	aux := ref_descritor.head_PalavrasChaves; // aux aponta para a primeira palavra do dict
    	
    	if (aux^.proximo = nil) then  // só existe um elemento, então:
    	begin
    		if aux^.palavra_chave = ref_descritor.palavra_chave_user then  // ele é a palavra informada?
    		begin
    			if aux^.ponteiro_dict = nil then
    				writeln('Não existe dicionário de Verbetes para consultar. Crie Verbetes para a Palavra-Chave: "',ref_descritor.palavra_chave_user,'"')
    			else
    			begin
						ref_descritor.encontrada := True;
						i := 1;
						aux2:= aux^.ponteiro_dict;
						writeln('=====================================================');	
						writeln('Palavra-Chave: ',aux^.palavra_chave);
						writeln('=====================================================');	
						escrever_dicionario_escolhido := escreve_itens(aux2, i);
					end;
				end
				else
					writeln('Essa Palavra-Chave não foi cadastrada ou sua ortografia está incorreta. Tente Novamente');		
    	end
    	
    	else // possui mais de um elemento
    	begin
	    	while (aux^.proximo <> nil) and (ref_descritor.encontrada = False) do
	    	begin // ou esse while encerra pq não existe a PC informada ou encerra pq achou
	    		if aux^.palavra_chave = ref_descritor.palavra_chave_user then
	    			begin
	    				ref_descritor.encontrada := True;
	    				aux2 := aux^.ponteiro_dict;
	    			end
	    		else
	    			aux:= aux^.proximo;
	    	end;
	    	
	    	if ref_descritor.encontrada = False then
	    		writeln('Essa Palavra-Chave não foi cadastrada ou sua ortografia está incorreta. Tente Novamente')
	    	else
	    	begin
	    		
	    		i := 1; 
	    		escrever_dicionario_escolhido := escreve_itens(aux2, i);
	    	end;
	    end;
   end;
end;   


////////////////////////////////////////////////////////////
{function buscar_traducao(ref_descritor);
begin                                   
end;                                     }
////////////////////////////////////////////////////////////

function consultar_palavra_chave(ref_descritor: programa): integer;//5
var i   : integer;                                            // até que seria legal transformar em função, mas é tão simples esse bloco que nem vale
var aux : ptLista;
begin
    if (ref_descritor.head_PalavrasChaves = nil) then
    begin                                                         
        i := 0;
        writeln('=====================================================');	;
        writeln('Lista de Palavras-Chaves vazia. Nada para exibir :/ ');
    end
    else
    begin
        aux := ref_descritor.head_PalavrasChaves;
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
Begin    
	
	cria_lista_palavras(descritor);                           
	descritor.opcao := 10;
	while descritor.opcao <> 0 do
	begin
		writeln('=====================================================');	
	  writeln('1 - Incluir Palavra-Chave'); 				// 1 //FEITO  
		writeln('2 - Remover Palavra-Chave');               // 7 //
		writeln('3 - Incluir Verbete no Dicionário');       // 2 //FEITO
		writeln('4 - Remover Verbete do Dicionário');       // 4 //
		writeln('5 - Escrever Todas as Palavras de Todos os Dicionário'); // 6 {FAZER OPÇÃO CRESCENTE OU DECRESCENTE}
		writeln('6 - Escrever Dicionário de sua Escolha');  // 3 //FEITO 
		writeln('7 - Buscar Tradução');                     // 5 // -> pede palavra ptbr -> encontra a pc maior -> acessa -> busca valor -> write palavra ingles
		writeln('8 - Consultar Palavras-Chaves');           // 0 //FEITO
		writeln('0 - Sair');
		writeln('=====================================================');		
		writeln('Escolha uma das opções a cima: ');
		readln(descritor.opcao);                   
		 
		
		if descritor.opcao = 1 then // incluir palavra chave 													OK
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
			
		else if descritor.opcao = 3 then   // incluir no dicionário automáticamente  OK
		begin
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
		  descritor.contagem := escrever_dicionario_escolhido(descritor);
		  writeln('Quantidade de Verbetes: ',descritor.contagem);
		  writeln('=====================================================');	
			limpa_tela();
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
			writeln('=====================================================');	
			limpa_tela();
		end;
	end;
end.
{// Aqui vão ser inseridas todas, ou as mais importantes, variaveis, assim como uma explicação do que ela faz: 
-
-
//}
{
//O protótipo deve ter as opções: incluir a palavra-chave, incluir no dicionário, remover do dicionário, consultar, escrever todo dicionário//
-O programa deve permitir cadastrar PALAVRAS-CHAVES (PC)
-Ao criar uma palavra-chave nova intermediária de duas já existêntes (ex: [D]-*[G]*-[M]), teremos que transferir as possíveis palavras D < G < M para que estão em [M] para [G]

}
