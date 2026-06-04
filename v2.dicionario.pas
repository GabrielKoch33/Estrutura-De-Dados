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
				head_PalavrasChaves: ptLista;
				tail_PalavrasChaves: ptLista;
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
		 ref_descritor.ListaPalavrasChaves	:= nil;
		 ref_descritor.head_PalavrasChaves	:= nil;
		 ref_descritor.tail_PalavrasChaves	:= nil;
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
		writeln('Digite o Verbete em Português: ');
		readln(ref_descritor.palavra_portugues);
		ref_descritor.palavra_portugues := upcase(ref_descritor.palavra_portugues);
		writeln('Digite o Verbete em Inglês: ');
		readln(ref_descritor.palavra_ingles);
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
					node^.palavra_chave									 := ref_descritor.palavra_chave;
					node^.ponteiro_dict									 := nil;
					node^.proximo												 := nil;
				  ref_descritor.head_PalavrasChaves		 := node; //inicio aponta para o 1º inserido
          ref_descritor.tail_PalavrasChaves		 := node; //fim também, afinal o unico elemento é o primeiro e o ultimo 
					 
					writeln('Palavra-Chave: "',node^.palavra_chave,'" adicionada!'); 
					readkey;
					limpa_tela();
				end                                
			else                                                                                                                                                         
			   // verfica duplicatas quando se tem pelo menos um elemento
				begin
					ref_descritor.duplicada := False;
					aux:= ref_descritor.head_PalavrasChaves;  
					while (aux <> nil) and (ref_descritor.duplicada = False) do
						begin
							if aux^.palavra_chave = ref_descritor.palavra_chave then
								begin
									writeln('A palavra-Chave: "',ref_descritor.palavra_chave,'" já está no dicionário! Duplicadas não são permitidas');
									readkey;
									limpa_tela();
								  ref_descritor.duplicada := True;
								end;
							aux:= aux^.proximo;
						end;
					// tudo aqui embaixo só será executado se NÃO houver duplicidade
						
					if (ref_descritor.palavra_chave < ref_descritor.head_PalavrasChaves^.palavra_chave) and (ref_descritor.duplicada = False) then 
						begin// verifica se a palavra a ser incluida é a menor de todas, até mesmo que a 1ª da lista 	
							
							node^.anterior                                := nil;                        
							node^.palavra_chave 													:= ref_descritor.palavra_chave;
							node^.ponteiro_dict														:= nil;
							node^.proximo																	:= ref_descritor.head_PalavrasChaves;
							ref_descritor.head_PalavrasChaves^.anterior 	:= node;
							ref_descritor.head_PalavrasChaves 						:= node;
							
								
							writeln('Palavra-Chave: "',node^.palavra_chave,'" adicionada!'); 
							readkey;	
							limpa_tela();
						end
					
					else if (ref_descritor.palavra_chave > ref_descritor.tail_PalavrasChaves^.palavra_chave) and (ref_descritor.duplicada = False) then
						begin   // verifica se a palavra é a maior de todas
						
							node^.anterior                                := ref_descritor.tail_PalavrasChaves;                        
							node^.palavra_chave 													:= ref_descritor.palavra_chave;
							node^.ponteiro_dict														:= nil;
							node^.proximo																	:= nil;
							ref_descritor.tail_PalavrasChaves^.proximo    := node;
							ref_descritor.tail_PalavrasChaves 						:= node;
								
							writeln('Palavra-Chave: "',node^.palavra_chave,'" adicionada!'); 
							readkey;	
							limpa_tela();	
						end
						
					else if (ref_descritor.duplicada = False) then // se não é a menor e nem a maior, então percorre
						begin
							ref_descritor.adicionado:= False;
						  aux:= ref_descritor.head_PalavrasChaves;
							  
							while (aux^.palavra_chave < ref_descritor.palavra_chave) and (aux^.proximo <> nil) do
							    aux := aux^.proximo; // axu para um Nó na frente do que se deseja incluir
							
						   aux2 							 	:= aux^.anterior;
						   node^.anterior      	:= aux2;
							 node^.palavra_chave 	:= ref_descritor.palavra_chave;
							 node^.ponteiro_dict 	:= nil;
							 node^.proximo       	:= aux;
							 aux2^.proximo       	:= node;
							 aux^.anterior       	:= node;
							 ref_descritor.adicionado := True;
							 writeln('Palavra-Chave: "', node^.palavra_chave, '" adicionada!');
							 readkey;
							 limpa_tela();
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
		end
		
		//se estivermos na última posição e ainda sim o último elemento for uma Palavra Chave menor que a que queremos incluir, então não existe palavras chaves compativel
		else if (ref_descritor.tail_PalavrasChaves^.palavra_chave < ref_descritor.palavra_portugues) then  
		begin
			writeln('Não existe palavra-chave para suportar este Verbete, crie uma nova Palavra-Chave maior que ',ref_descritor.tail_PalavrasChaves^.palavra_chave);
		end
				
		else // Se for possível adicionar o verbete, então esse else ocorre
			begin
				limpa_tela();
				new(node);
        if node = nil then
					writeln('Memória Cheia!')
				else
				begin
					ler_palavras_pt_ing(descritor);
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
						 end
					   else// se possuir elementos, então verifica duplicadas
						 begin
								aux2 := aux^.ponteiro_dict;				
								if verifica_duplicada_no_dict(ref_descritor, aux2) = True then
									writeln('O Verbete ',ref_descritor.palavra_portugues,' já está no dicionário! Duplicadas não são permitidas!')
								else
									begin
										 ref_descritor.adicionado := False;
										 aux3 := aux2;
										 while (aux3^.prox_dicionario <> nil) and ( aux3^.verbete_PTBR < ref_descritor.palavra_portugues ) do
										 begin
										 	aux2:= aux3^.prox_dicionario;
										 	if aux3^.verbete_PTBR > ref_descritor.palavra_portugues then //verifica as posições a fim de encontrar ANTERIOR(aux2) e POSTERIOR(aux3)
										 		begin
										  			node^.verbete_PTBR 		   := ref_descritor.palavra_portugues;
								  					node^.verbete_ING 		   := ref_descritor.palavra_ingles;
										  			node^.prox_dicionario 	 := aux3;
										  			aux2^.prox_dicionario 	 := node;
										  			ref_descritor.adicionado := True;
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
										 	end;
									  writeln('O verbete: "', ref_descritor.palavra_portugues,'" | "',ref_descritor.palavra_ingles,'" foi adicionado à Palavra-Chave: "', ref_descritor.head_PalavrasChaves^.palavra_chave);
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
            end
            else // se a última PC possuir elementos: 
            begin
                aux2 := aux^.ponteiro_dict;
                if verifica_duplicada_no_dict(ref_descritor, aux2 = True) then
                    writeln('O Verbete ', ref_descritor.palavra_portugues, ' já está no dicionário! Duplicadas não são permitidas!')
                else 
                begin
                	ref_descritor.adicionado := False;
									aux3 := aux2;
									while (aux3^.prox_dicionario <> nil) and ( aux3^.verbete_PTBR < ref_descritor.palavra_portugues ) do
										begin
											 aux2:= aux3^.prox_dicionario;
											 if aux3^.verbete_PTBR > ref_descritor.palavra_portugues then //verifica as posições a fim de encontrar ANTERIOR(aux2) e POSTERIOR(aux3)
											 		begin
											  			node^.verbete_PTBR 		   := ref_descritor.palavra_portugues;
									  					node^.verbete_ING 		   := ref_descritor.palavra_ingles;
											  			node^.prox_dicionario 	 := aux3;
											  			aux2^.prox_dicionario 	 := node;
											  			ref_descritor.adicionado := True;
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
												end;
									 	writeln('O verbete: "', ref_descritor.palavra_portugues,'" | "',ref_descritor.palavra_ingles,'" foi adicionado à Palavra-Chave: "', ref_descritor.tail_PalavrasChaves^.palavra_chave);
								end;
            end;
        end
        else
					begin
						 // procura a posição qualquer
					end
    end; 
end;     
				
				
				
				else // caso a palavra chave de inserção não seja a primeira nem a última, então esse else procura a palavra no dicionário
				begin
				  while (aux^.palavra_chave < ref_descritor.palavra_portugues) and (aux^.proximo <> nil) do 
				  begin 	
						aux := aux^.proximo; // aux é setado na PC correta
					end;
					aux2 := aux^.ponteiro_dict;				
					verifica_duplicada_no_dict(ref_descritor, aux2);					 				
					
   				if ref_descritor.duplicada = False then
						begin
						    if node = nil then
						    	writeln('Memória Cheia!')
						    	
						    else if (aux^.ponteiro_dict = nil) then // se essa for a primeira palavra a ser incluido então esse Else if ocorre
							    	begin  
							    		node^.verbete_PTBR 				:= ref_descritor.palavra_portugues;
							    		node^.verbete_ING 				:= ref_descritor.palavra_ingles;
							    		node^.prox_dicionario 		:= nil;
							    		aux^.ponteiro_dict 				:= node;
							    	end
								    	
							  else // caso já haja palavra já associadas a palavra chave, esse Else ocorre
							      begin  
										   aux2:= aux^.ponteiro_dict;
							      	   if (ref_descritor.palavra_portugues < aux2^.verbete_PTBR) then// caso for menor que a primeira
							      	   		begin
			
							      	   	  	node^.verbete_PTBR		 := ref_descritor.palavra_portugues;
							      	   	  	node^.verbete_ING 		 := ref_descritor.palavra_ingles;
							      	   	  	node^.prox_dicionario  := aux2;
							      	   	  	aux^.ponteiro_dict		 := node;
							      	   		end
							      	   else  // esse Else vai tratar de encontrar a posição correta e inserir
							      	   		begin
								      	   		    /// percorre as palavras cadastradas a fim de encontrar a posição de inserção
								      	   		    
							      	   		end;
								    end;
						end;
					end;
				end	
				
				
				else //momento de percorrer o a lista em busca da palavra certa
							// caso não existam duplicadas: 	

			end;		
			
end;
//procedure remover_palavra_do_dicionario()//4
//function escrever_dicionario()   //6

function consultar_palavra_chave(ref_descritor: programa): integer;//5
var i   : integer;
var aux : ptLista;
begin
    if (ref_descritor.head_PalavrasChaves = nil) then
    begin
        i := 0;
        writeln('=====================================================');	;
        writeln('Lista de Palavras-Chaves vazia. Nada para exibir :( ');
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
Begin        {FAZER INICIO E FIM DA LISTA, PARA QUE POSSA SER PERCORRIDA DE TRÁS PARA FRENTE}
	
	cria_lista_palavras(descritor);                           
	descritor.opcao := 10;
	while descritor.opcao <> 0 do
	begin
		writeln('=====================================================');	
	  writeln('1 - Incluir Palavra-Chave'); 				      // 1 //FEITO  
		writeln('2 - Remover Palavra-Chave');               // 7
		writeln('3 - Incluir Palavra no Dicionário');       // 2 //EM PROGRESSO
		writeln('4 - Remover Palavra do Dicionário');       // 3 //
		writeln('5 - Escrever Todas as Palavras de Todos os Dicionário'); // 6 
		writeln('6 - Escrever Dicionário de sua Escolha');  // 4       Tornar a 5 e 6 uma unica função?
		writeln('7 - Buscar Tradução');                     // 5
		writeln('8 - Consultar Palavras-Chaves'); 
		writeln('0 - Sair');
		writeln('=====================================================');		
		writeln('Escolha uma das opções a cima: ');
		read(descritor.opcao);                   
		 
		
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
			writeln('=====================================================');	
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
