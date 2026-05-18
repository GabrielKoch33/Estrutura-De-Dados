Program dicionarioBastos ;


type 	tipo_inf = string;
    		ptLista = ^lista;// permite apontar para palavras-chaves anteriores e posteriores
    		ptDict = ^dicionario; //permite apontar de palavras-chaves para dicionário como de dict -> dict
    	  end;
    	  
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
		 		palavra: tipo_inf;
		 		ListaPalavrasChaves: ptLista;
		 		end;
		 
var
	 descritor: programa;
	 
////////////////////////////////////////////////////////////	 
procedure cria_lista_palavras(var ref_descritor: programa);
begin
		 ref_descritor.ListaPalavrasChaves:= nil;
end;

////////////////////////////////////////////////////////////
procedure ler_palavra(var ref_descritor: programa);
begin
    writeln('digite uma PALAVRA-CHAVE: ');
    readln(ref_descritor.palavra);
end;

////////////////////////////////////////////////////////////
procedure incluir_palavra_chave(var ref_descritor: programa);
var node,aux,aux2: ptLista;
begin
	new(node);//node é igual a aux nos primeiros códigos, node = nó = estrutura basica do [anterior,dado,dict,prox]
	if node = nil then
	 		writeln('Memória Cheia')
	else
		begin
			if ref_descritor.ListaPalavrasChaves = nil then // se for a primeira palavra-chave a ser incluida
				begin
 					node^.anterior := nil;
					node^.palavra_chave := ref_descritor.palavra;
					node^ponteiro_dict:= nil;
					node^.proximo:= nil;
					ref_descritor.ListaPalavrasChaves = node; 			 	
				end
			else
				begin
					if ref_descritor.palavra < ref_descritor.ListaPalavrasChaves^.palavra_chave then // Esse IF verifica se a palavra a ser incluida é a menor de todas, até mesmo que a 1ª da lista
					begin 	
						node^.anterior := nil;
						node^.palavra_chave := ref_descritor.palavra;
						node^.ponteiro_dict:= nil;
						node^.proximo:= ref_descritor.ListaPalavrasChaves;
						ref_descritor.ListaPalavrasChave^.anterior := node;
						ref_descritor.ListaPalavrasChaves := node;		
					end
					else // agora é onde iremos perocorrer os nós até achar uma posição que se encaixe
					begin
					  aux:= ref_descritor.ListaPalavrasChaves; // o papel de aux será armazenar o endereço do nó ANTERIOR a nova inserção
					  aux2:= ref_descritor.ListaPalavrasChaves; // o papel de aux2 é armazenar o endereço do nó POSTERIOR a nova inserção
						while (aux^.palavra_chave < ref_descritor.palavra) and (aux2^.proximo <> nil) do
						begin
							   aux2:= aux2^.proximo;//antes de parar o while, e caso a posição que será inserida for a última, então aux2 parará no último nó criado, tornando false a condição do while e saindo do loop
							   if aux2^.palavra_chave >= ref_descritor.palavra then // se a palavra que aux2 estiver apontado for maior que a inserção, então aux1 ainda estará na anterior a essa, permitindo a conexão
							   begin
							   		 node^.anterior := aux;
							   		 node^.palavra_chave:=ref_descritor.palavra;
							   		 node^.ponteiro_dict:= nil;
							   		 node^.proximo:= aux2;
							   		 aux2^.anterior:= node;
							   		 aux^.proximo:=node;
							   		 break;// se quiser tirar esse break só faz uma flag de true/false no while
							   end
							   else // caso não encontre uma posição intermediária para inserir, então aux += aux
							   		aux:= aux^.proximo;
						end;
						if aux2^.proximo = nil then// caso aux2 pare na última posição: node é 'populado' e ligado a lista
						begin
							node^.anterior := aux2;
							node^.palava_chave := ref_descritor.palavra;
							node^.ponteiro_dict:= nil;
							node^.proximo:=nil;
							aux2^.proximo:= node;
						end
					end;
				end;
		end;
end;


////////////////////////////////////////////////////////////
Begin
	descritor.palavra = '';
	cria_lista_palavras(descritor);
	
	while descritor.opcao <> 0 do
	begin
	  writeln('1 - Incluir Palavra-Chave');
		writeln('2 - Remover Palavra-Chave'); 	//botei por precaução
		writeln('3 - Incluir no Dicionário');
		writeln('4 - Remover do Dicionário');
		writeln('4 - Consultar'); 							//consultar oq?
		writeln('5 - Escrever Dicionário');     // imagino que seja todo o dicionáio de uma palavra-chave específica
		writeln('0 - Sair');		
		writeln('Escolha uma das opções a cima: ');
		readln(descritor.opcao);                    
		
		if descritor.opcao = 1 then
		begin
			ler_palavra(descritor);
			incluir_palavra_chave(descritor);
		end
		
		//else if descritor.opcao = 2 then
			//remover_palavra_chave()
			
		else if descritor.opcao = 3 then
		begin
			ler_palavra(descritor);
			incluir_no_dicionario();
		end
		
		else if descritor.opcao = 4 then
		begin
			ler_palavra(descritor);
			remover_do_dicionario();
		end
		
		else if descritor.opcao = 5 then
			consultar()
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
