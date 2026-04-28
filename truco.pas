Program Pzim ;
// Truco

	type treg_carta = record
			 		peso: integer;
			 		naipe: string;
			 		numero: integer;
			 		classe: integer; // A classe é como se fosse o número da carta
			// Porém, as cartas 4 possuem classe 1, até as cartas 3, que são as mais fortes que possuem classe 10 		
			 end;
	
	type treg_lista_baralho = record
			 		vListaBaralho: array[1..40] of treg_carta; 
			 		posicao: integer;
			 end;
	
	type treg_pilha_baralho = record
					vPilhaBaralho: array[1..40] of treg_carta;
					posicao: integer;
			 end;
	
	type treg_fila_baralho_cortado = record	
	 	 	 		vFilaBaralho: array[1..39] of treg_carta; //pelo menos uma carta deve ser cortada
			 end;
	
	type treg_lista_cartas = record
			 		vListaCartasMao: array[1..3] of treg_carta;
			 end;
	
	type treg_jogo = record
			 		pontuacaoJogador: integer;
			 		pontuacaoComputador: integer;
			 		numeroCartasJogador: integer;
			 		// Armazena quantas cartas tem na mão, servindo como posição
			 		numeroCartasComputador: integer;
			 		pontuacaoJogadorMao: integer;
			 		pontuacaoComputadorMao: integer;
			 		embaralhamento: integer; // vez de quem embaralha
			 		vez: boolean; // vez de quem joga, se for o jogador é true
			 		vezReacao: boolean; // vez que só é alterada dentro da mesma mão
			 		quantidadeCartasJogadas: integer; // Quantidade de cartas jogadas por mão
			 		cartaJogador: treg_carta; // Armazena a carta que o jogador jogou
			 		cartaComputador: treg_carta; // Armazena a carta que o computador jogou
			 		contadorEmpachado: integer; // Conta a quantidade de rodadas empachadas
			 		trucado: boolean; // Começa como falso cada mão
			 		pontuacaoTrucado: integer; // Pode ir de 3 até 12 
			 		correu: boolean; // recebe true se alguém correu da mão
			 end;
	 
	var i: integer; 
	// As reações 2, 3 e 4 só são chamadao quando o truco é aumentado além de 3
	var objetoBaralho: treg_lista_baralho;
	var objetoPilhaBaralho: treg_pilha_baralho;
	var objetoFilaBaralhoCortado: treg_fila_baralho_cortado;
	var objetoCartasJogador: treg_lista_cartas;
	var objetoCartasComputador: treg_lista_cartas;
	var objetoJogo: treg_jogo;
	
	procedure preencherBaralho(var ref_objeto_baralho: treg_lista_baralho); 
	// 1 é a carta mais de baixo do baralho, 40 é a mais de cima
		var i, contador: integer;
		begin
			for i:= 1 to 40 do
				begin
					ref_objeto_baralho.vListaBaralho[i].peso:=i*10;
					//Posso multiplicar o i por 10 por exemplo para não confundir com as posições do baralho.
				end;
			contador:= contador+1;
			for i:= 1 to 10 do
				begin
					ref_objeto_baralho.vListaBaralho[contador].naipe:= 'Ouros';
					contador:= contador+1;
					ref_objeto_baralho.vListaBaralho[contador].naipe:= 'Espadas';
					contador:= contador+1;
					ref_objeto_baralho.vListaBaralho[contador].naipe:= 'Copas';
					contador:= contador+1;
					ref_objeto_baralho.vListaBaralho[contador].naipe:= 'Paus';
					contador:= contador+1;	
				end;
			for i:= 1 to 40 do
				begin
					if i<5 then
						begin
							ref_objeto_baralho.vListaBaralho[i].classe:=1;
							ref_objeto_baralho.vListaBaralho[i].numero:=4;
						end
					else if i<9 then
						begin
							ref_objeto_baralho.vListaBaralho[i].classe:=2;
							ref_objeto_baralho.vListaBaralho[i].numero:=5;
						end
					else if i<13 then
						begin
							ref_objeto_baralho.vListaBaralho[i].classe:=3;
							ref_objeto_baralho.vListaBaralho[i].numero:=6;
						end
					else if i<17 then
						begin
							ref_objeto_baralho.vListaBaralho[i].classe:=4;
							ref_objeto_baralho.vListaBaralho[i].numero:=7;
						end
					else if i<21 then
						begin
							ref_objeto_baralho.vListaBaralho[i].classe:=5;
							ref_objeto_baralho.vListaBaralho[i].numero:=10;
						end
					else if i<25 then
						begin
							ref_objeto_baralho.vListaBaralho[i].classe:=6;
							ref_objeto_baralho.vListaBaralho[i].numero:=11;
						end	
					else if i<29 then
						begin
							ref_objeto_baralho.vListaBaralho[i].classe:=7;
							ref_objeto_baralho.vListaBaralho[i].numero:=12;
						end	
					else if i<33 then
						begin
							ref_objeto_baralho.vListaBaralho[i].classe:=8;
							ref_objeto_baralho.vListaBaralho[i].numero:=1;
						end	
					else if i<37 then
						begin
							ref_objeto_baralho.vListaBaralho[i].classe:=9;
							ref_objeto_baralho.vListaBaralho[i].numero:=2;
						end	
					else
						begin 
							ref_objeto_baralho.vListaBaralho[i].classe:=10;
							ref_objeto_baralho.vListaBaralho[i].numero:=3;
						end			
				end; 
			writeln;			
		end;
	
	
	procedure embaralhar(var ref_objeto_baralho: treg_lista_baralho; var ref_objeto_pilha_baralho: treg_pilha_baralho);
		var i, posicaoAuxiliar, posicaoAuxiliar2: integer;
		var auxiliar: treg_carta;
		begin
			for i:= 1 to 100 do                                   
				begin
					posicaoAuxiliar:= random(40)+1;
					posicaoAuxiliar2:= random(40)+1;
					auxiliar:= ref_objeto_baralho.vListaBaralho[posicaoAuxiliar];
					ref_objeto_baralho.vListaBaralho[posicaoAuxiliar]:=ref_objeto_baralho.vListaBaralho[posicaoAuxiliar2];
					ref_objeto_baralho.vListaBaralho[posicaoAuxiliar2]:=auxiliar;
				end;
			for i:= 1 to 40 do
				begin
					ref_objeto_pilha_baralho.vPilhaBaralho[i]:= ref_objeto_baralho.vListaBaralho[i];
				end	
		end;

  procedure cortar(ref_objeto_pilha_baralho: treg_pilha_baralho;
	 								 var ref_objeto_fila_baralho_cortado: treg_fila_baralho_cortado;
	 								 ref_objeto_jogo: treg_jogo);
  	var i, j, posicao_cortado: integer;
  	begin
  		j:= 1;
  		if ref_objeto_jogo.embaralhamento mod 2 = 0 then // O jogador só corta se o computador embaralhar e dar as cartas
  			repeat
  				writeln('Informe a posicao que você deseja cortar o baralho. (entre 2 e 34)');
  				readln(posicao_cortado);
  			until ((posicao_cortado>1) and (posicao_cortado<=34))
			else	
  			repeat
  				posicao_cortado:= random(40)+1;	
  			until ((posicao_cortado>1) and (posicao_cortado<=34));
  		writeln('A posição que o baralho foi cortado foi: ',posicao_cortado);
  		for i:= posicao_cortado to 40 do  //Preenchendo a fila com os valores da pilha
  			begin
  				ref_objeto_fila_baralho_cortado.vFilaBaralho[j]:= ref_objeto_pilha_baralho.vPilhaBaralho[i];
  				j:= j+1;
  			end
  	end;
  	
  procedure trataManilha(var ref_fila_baralho_cortado: treg_fila_baralho_cortado);
		var i, determinante_manilhas: integer; // serve para determinar as manilhas
		begin
			determinante_manilhas:= ref_fila_baralho_cortado.vFilaBaralho[7].classe;    
			for i:= 1 to 6 do
				begin
					if (determinante_manilhas=10) and (ref_fila_baralho_cortado.vFilaBaralho[i].classe = 1) then
							ref_fila_baralho_cortado.vFilaBaralho[i].peso:= ref_fila_baralho_cortado.vFilaBaralho[i].peso*100
					else if(ref_fila_baralho_cortado.vFilaBaralho[i].classe = (determinante_manilhas+1)) then
						// Esse if tá verificando se alguma carta do jogador é coringa
						ref_fila_baralho_cortado.vFilaBaralho[i].peso:= ref_fila_baralho_cortado.vFilaBaralho[i].peso*100;
							// Joguei o peso bem alto para diferenciar claramente o peso de uma carta normal com a de uma manilha  
				end;		
		end;
		
	procedure escreveCoringa(ref_fila_baralho_cortado: treg_fila_baralho_cortado);
		// Parecido com o procedimento de cima, porém, esse apenas exibe na tela o número das cartas coringa
		var determinante_manilhas: integer; // serve para determinar as manilhas
		begin
			determinante_manilhas:= ref_fila_baralho_cortado.vFilaBaralho[7].numero;
			if determinante_manilhas = 12 then
				writeln('os coringas desse jogo são as cartas de número 1')
			else
				writeln('os coringas desse jogo são as cartas de número ',determinante_manilhas+1);	 		
		end;
  
  procedure darAsCartas(var ref_objeto_cartas_jogador: treg_lista_cartas;
	 											var ref_objeto_cartas_computador: treg_lista_cartas;
												ref_objeto_fila_baralho_cortado: treg_fila_baralho_cortado;
												ref_objeto_jogo: treg_jogo);
		var i, cont_jogador, cont_computador: integer;
		begin
			cont_jogador:= 1;
			cont_computador:=1;
			if ref_objeto_jogo.embaralhamento mod 2 <> 0 then// Se for ímpar, o jogador embaralhou e a primeira carta é do computador
				for i:= 1 to 6 do
					if (i mod 2) <> 0 then
						begin                                  
							ref_objeto_cartas_computador.vListaCartasMao[cont_computador]:= ref_objeto_fila_baralho_cortado.vFilaBaralho[i];
							cont_computador:= cont_computador+1;
						end
					else
						begin
							ref_objeto_cartas_jogador.vListaCartasMao[cont_jogador]:= ref_objeto_fila_baralho_cortado.vFilaBaralho[i];
							cont_jogador:= cont_jogador+1;
						end		
			else
				for i:= 1 to 6 do
					if (i mod 2) <> 0 then
						begin
							ref_objeto_cartas_jogador.vListaCartasMao[cont_jogador]:= ref_objeto_fila_baralho_cortado.vFilaBaralho[i];
							cont_jogador:= cont_jogador+1;
						end
					else
						begin
							ref_objeto_cartas_computador.vListaCartasMao[cont_computador]:= ref_objeto_fila_baralho_cortado.vFilaBaralho[i];
							cont_computador:= cont_computador+1;
						end;		
		end;
		
		procedure escreverCartasJogador(ref_objeto_cartas_jogador: treg_lista_cartas;
																		ref_objeto_jogo: treg_jogo);
			var i: integer;
			begin		
				writeln('As suas cartas são:');
				writeln();
		    writeln('| PESO | NUMERO |    NAIPE    |');
		    writeln('--------------------------------');
				for i:= 1 to ref_objeto_jogo.numeroCartasJogador do
						 begin
					      write('[ ');
					      write(ref_objeto_cartas_jogador.vListaCartasMao[i].peso:6);
					      write(' | ');
					
					      write(ref_objeto_cartas_jogador.vListaCartasMao[i].numero:6);
					      write(' | ');
					
					      write(ref_objeto_cartas_jogador.vListaCartasMao[i].naipe:11);
					      write(' ]');
			
			      		writeln;
		   			 end;
  				 writeln('---------------------------------------------------------------------------------------------------------------------'); 
			end;
		
		function jogarCarta(var ref_objeto_cartas_jogador: treg_lista_cartas;
	 											var ref_objeto_cartas_computador: treg_lista_cartas;
	 											var ref_objeto_jogo: treg_jogo): treg_carta; // Retorna uma carta
			var posicao_carta: integer;
			var carta_escolhida: treg_carta;
			var i: integer; 
			begin
				if ref_objeto_jogo.vez = true then // Se for true, é porque é a vez do jogador
					begin
						//writeln('Informe qual carta você deseja jogar:');
						escreverCartasJogador(ref_objeto_cartas_jogador, ref_objeto_jogo);
						for i:= 1 to ref_objeto_jogo.numeroCartasJogador do
							begin
								write('[',i,'] ');	
							end;
						writeln('Informe qual carta você deseja jogar:');
						readln(posicao_carta);
						carta_escolhida:= ref_objeto_cartas_jogador.vListaCartasMao[posicao_carta];
						if posicao_carta <> ref_objeto_jogo.numeroCartasJogador then
							for i:= posicao_carta to ref_objeto_jogo.numeroCartasJogador-1 do
								ref_objeto_cartas_jogador.vListaCartasMao[i]:= ref_objeto_cartas_jogador.VlistaCartasMao[i+1];  
						ref_objeto_jogo.numeroCartasJogador:= ref_objeto_jogo.numeroCartasJogador-1;
						ref_objeto_jogo.cartaJogador:= carta_escolhida;
						write('Você jogou a carta : ',carta_escolhida.numero);
						writeln(' de ',carta_escolhida.naipe);
					end
				else
					begin
						posicao_carta:= random(ref_objeto_jogo.numeroCartasComputador)+1;
						carta_escolhida:= ref_objeto_cartas_computador.vListaCartasMao[posicao_carta];
						if posicao_carta <> ref_objeto_jogo.numeroCartasComputador then
							for i:= posicao_carta to ref_objeto_jogo.numeroCartasComputador-1 do
								ref_objeto_cartas_computador.vListaCartasMao[i]:= ref_objeto_cartas_computador.VlistaCartasMao[i+1];
						ref_objeto_jogo.numeroCartasComputador:= ref_objeto_jogo.numeroCartasComputador-1;
						ref_objeto_jogo.cartaComputador:= carta_escolhida;
						write('O computador jogou a carta : ',carta_escolhida.numero);
						writeln(' de ',carta_escolhida.naipe);
					end;
				jogarCarta:= carta_escolhida;		
			end;
			   
						   
		procedure reagir(var ref_objeto_jogo: treg_jogo); // Reação que o jogador e o computador tomam ao truco
			var valor: integer;
			begin
			  repeat
			  if ref_objeto_jogo.pontuacaoTrucado <> 12 then
			  	begin
						if ref_objeto_jogo.vezReacao = true then // Se é true, é pq é o jogador reagindo
							begin
								repeat
									writeln('O que você deseja fazer: [1] Aceitar truco, [2] Correr, [3] Aumentar Truco'); 
									readln(valor);  
								until (valor > 0) and (valor < 4);
							end
						else // Se for false, é o computador
							valor:= random(3)+1;
					end
				else // Se já está em 12, não pode mais aumentar o truco
					begin
						if ref_objeto_jogo.vezReacao = true then // Se é true, é pq é o jogador reagindo
							begin
								repeat
									writeln('O que você deseja fazer: [1] Aceitar truco, [2] Correr');
									readln(valor);  
								until (valor > 0) and (valor < 3);
							end
						else // Se for false, é o computador
							valor:= random(2)+1;
					end;
					
					
				// Tratamento da reação escolhida	
				if valor = 1 then
				// Esse procedimento não pode chamar o jogarCarta, pois é somente a reação
				// Não implica em mudanças no jogo esse procedimento, pois não há cartas sendo jogadas
					begin
						if ref_objeto_jogo.vezReacao = true then
						begin
							writeln('O jogador aceitou o truco!');
							writeln('---------------------------------------------------------------------------------------------------------------------');  
						end
						else
						begin
							writeln('O computador aceitou o truco!');
							writeln('---------------------------------------------------------------------------------------------------------------------');    
						end;
					end
				else if valor = 2 then 
					begin
						ref_objeto_jogo.quantidadeCartasJogadas:= 2; // Se ele correu, as cartasJogadas foram aumentadas para acabar o mao
						ref_objeto_jogo.pontuacaoTrucado:= ref_objeto_jogo.pontuacaoTrucado-3;
						// A pontuação diminui, pois se ele correu de um truco, ele não perde os pontos desse último truco
						if ref_objeto_jogo.vezReacao = true then
							begin
								ref_objeto_jogo.pontuacaoComputadorMao:= 2;
								writeln('O jogador correu!')	
							end
						else
							begin
								ref_objeto_jogo.pontuacaoJogadorMao:=2;
								writeln('O computador correu!')
							end;
						ref_objeto_jogo.correu:= true;
					end	
				else  // A vez da reação só pode mudar nesse else, quando o valor do truco é aumentada
					begin
						ref_objeto_jogo.pontuacaoTrucado:= ref_objeto_jogo.pontuacaoTrucado+3;
						if ref_objeto_jogo.vezReacao = true then
							writeln('O jogador pediu ',ref_objeto_jogo.pontuacaoTrucado)
						else
							writeln('O computador pediu ',ref_objeto_jogo.pontuacaoTrucado);
						ref_objeto_jogo.vezReacao:= not ref_objeto_jogo.vezReacao; //Inverte a vez
						// Na próxima vez que a decisão for chamada, somente quem tem a vez da reação pode aumentar o truco
					end
				until valor <> 3
			end;  
			
		
		procedure decisao(var ref_objeto_jogo: treg_jogo); // Decisão que o jogador e o computador tomam
			var valor: integer;
			begin
				if ref_objeto_jogo.trucado = false then
					begin
						if ref_objeto_jogo.vez = true then
							begin
								repeat
									writeln('O que você deseja fazer: [1] Jogar carta, [2] Trucar');
									readln(valor); 
									writeln('---------------------------------------------------------------------------------------------------------------------');  
								until (valor > 0) and (valor < 3);
							end
						else
							valor:= random(2)+1;
					end
				else
					begin                                
		      	if ref_objeto_jogo.vez = true then
							begin
								if (ref_objeto_jogo.vezReacao = true) and (ref_objeto_jogo.pontuacaoTrucado <> 12) then
									begin
										repeat
											writeln('O que você deseja fazer: [1] Jogar carta, [2] Aumentar truco');
											readln(valor);  
											writeln('---------------------------------------------------------------------------------------------------------------------');     
										until (valor > 0) and (valor < 3);
									end
								else // Só pode Aumentar nesse caso, se for a vez de reagir, e se a pontuação já não estiver em 12
								// Esse filtro da pontuação 12 já é tratado no procedimento reagir, só que é necessário nesse
								// também, pois o jogador/computador pode querer aumentar a qualquer momento da partida
									begin
										repeat
											writeln('Digite 1 para jogar a carta');
											readln(valor);
											writeln('---------------------------------------------------------------------------------------------------------------------');  
										until valor = 1
									end;
							end
						else
							begin
								if (ref_objeto_jogo.vezReacao = false) and (ref_objeto_jogo.pontuacaoTrucado <> 12) then
									begin
										valor:= random(2)+1;
									end
								else
									valor:= 1
							end
							
					end;
				
				// Tratamento da decisao
				if valor = 1 then
					begin
						jogarCarta(objetoCartasJogador, objetoCartasComputador, objetoJogo);
						objetoJogo.quantidadeCartasJogadas:= objetoJogo.quantidadeCartasJogadas+1;
						objetoJogo.vez:= not objetoJogo.vez; // Inverte para a vez ser do próximo
			  	end
				else
					if objetoJogo.trucado = false then
						begin
							objetoJogo.trucado:= true; // Só pode trucar uma vez por mão
							ref_objeto_jogo.pontuacaoTrucado:= 3;
							objetoJogo.vezReacao:= not objetoJogo.vez; // A reação é do jogador adversário
							writeln('A decisão foi trucar!');
							reagir(objetoJogo);				 
						end
					else // Se já estiver trucado
						begin
							ref_objeto_jogo.pontuacaoTrucado:= ref_objeto_jogo.pontuacaoTrucado+3;
							objetoJogo.vezReacao:= not objetoJogo.vez;
							writeln('A decisão foi aumentar o truco para ',ref_objeto_jogo.pontuacaoTrucado);
							reagir(objetoJogo);	
						end	
						
			end;
			
			
			procedure decidePonto(var ref_objeto_jogo: treg_jogo);
				begin
					if ref_objeto_jogo.cartaJogador.numero = ref_objeto_jogo.cartaComputador.numero then
						begin
							if ref_objeto_jogo.cartaJogador.peso<1000 then // Se é menor que 1000, não são coringas
								begin
									ref_objeto_jogo.contadorEmpachado:= ref_objeto_jogo.contadorEmpachado+1;
									writeln('A rodada empachou!');
									writeln('---------------------------------------------------------------------------------------------------------------------');  
								end
							else
								begin
									if ref_objeto_jogo.cartaJogador.peso > ref_objeto_jogo.cartaComputador.peso then
										begin
											if ref_objeto_jogo.contadorEmpachado <> 0 then
												ref_objeto_jogo.pontuacaoJogadorMao:= ref_objeto_jogo.pontuacaoJogadorMao+1+ref_objeto_jogo.contadorEmpachado
											else
												ref_objeto_jogo.pontuacaoJogadorMao:= ref_objeto_jogo.pontuacaoJogadorMao+1;
											writeln('O jogador pontuou!');
											writeln('---------------------------------------------------------------------------------------------------------------------');   
										end
									else
										begin
											if ref_objeto_jogo.contadorEmpachado <> 0 then
												ref_objeto_jogo.pontuacaoComputadorMao:= ref_objeto_jogo.pontuacaoComputadorMao+1+ref_objeto_jogo.contadorEmpachado
											else
												ref_objeto_jogo.pontuacaoComputadorMao:= ref_objeto_jogo.pontuacaoComputadorMao+1;
											writeln('O computador pontuou!');	
											writeln('---------------------------------------------------------------------------------------------------------------------'); 
										end;
								end
						end
					else
						begin
							if ref_objeto_jogo.cartaJogador.peso > ref_objeto_jogo.cartaComputador.peso then
								begin
									if ref_objeto_jogo.contadorEmpachado <> 0 then
										ref_objeto_jogo.pontuacaoJogadorMao:= ref_objeto_jogo.pontuacaoJogadorMao+1+ref_objeto_jogo.contadorEmpachado
									else
										ref_objeto_jogo.pontuacaoJogadorMao:= ref_objeto_jogo.pontuacaoJogadorMao+1;
									writeln('O jogador pontuou!');
									writeln('---------------------------------------------------------------------------------------------------------------------');    
								end
							else
								begin
									if ref_objeto_jogo.contadorEmpachado <> 0 then
										ref_objeto_jogo.pontuacaoComputadorMao:= ref_objeto_jogo.pontuacaoComputadorMao+1+ref_objeto_jogo.contadorEmpachado
									else
										ref_objeto_jogo.pontuacaoComputadorMao:= ref_objeto_jogo.pontuacaoComputadorMao+1;
									writeln('O computador pontuou!');
									writeln('---------------------------------------------------------------------------------------------------------------------');   
								end;	
						end;		
				end;
				
			procedure decidePontuacao(var ref_objeto_jogo: treg_jogo); // Decide a pontuação da mão
				begin
					if ref_objeto_jogo.pontuacaoTrucado = 0 then
						begin
							if ref_objeto_jogo.pontuacaoJogadorMao > 1 then
								begin
									ref_objeto_jogo.pontuacaoJogador:= ref_objeto_jogo.pontuacaoJogador+1;
									writeln('O jogador fez 1 ponto nessa mão!')
								end
							else
								begin
									if ref_objeto_jogo.pontuacaoComputadorMao > 1 then
										begin
											ref_objeto_jogo.pontuacaoComputador:= ref_objeto_jogo.pontuacaoComputador+1;
											writeln('O computador fez 1 ponto nessa mão!')
										end
									else
										writeln('As três rodadas empacharam, essa mão empatou');
								end;
						end
					else
						begin
							if ref_objeto_jogo.pontuacaoJogadorMao > 1 then
								begin
									ref_objeto_jogo.pontuacaoJogador:= ref_objeto_jogo.pontuacaoJogador+ref_objeto_jogo.pontuacaoTrucado;
									writeln('O jogador fez ',ref_objeto_jogo.pontuacaoTrucado,' pontos nessa mão!')
								end
							else
								begin
									if ref_objeto_jogo.pontuacaoComputadorMao > 1 then
										begin
											ref_objeto_jogo.pontuacaoComputador:= ref_objeto_jogo.pontuacaoComputador+ref_objeto_jogo.pontuacaoTrucado;
											writeln('O computador fez ',ref_objeto_jogo.pontuacaoTrucado,' pontos nessa mão!')
										end
									else
										writeln('As três rodadas empacharam, essa mão empatou');
								end;
						end
				end;										
  
  // Escritas
  
  	procedure escreverBaralho(ref_baralho: treg_lista_baralho);
			var i: integer;
			begin
				for i:= 1 to 40 do
					begin
						write(ref_baralho.vListaBaralho[i].numero,' de ');
						write(ref_baralho.vListaBaralho[i].naipe,' ');
						write('Peso: ',ref_baralho.vListaBaralho[i].peso,' ');
						write('Classe: ',ref_baralho.vListaBaralho[i].classe);
						writeln;
					end;
			end;
  	
  
  	procedure escreverPilhaBaralho(ref_pilha_baralho: treg_pilha_baralho);
			var i: integer;
			begin
				for i:= 1 to 40 do
					begin
						write(ref_pilha_baralho.vPilhaBaralho[i].peso,' - ');
						write(ref_pilha_baralho.vPilhaBaralho[i].numero,' - ');
						write(ref_pilha_baralho.vPilhaBaralho[i].naipe,' ');
						writeln;
					end;
			end;
		
		procedure escreverFilaBaralho(ref_objeto_fila_baralho_cortado: treg_fila_baralho_cortado);
			var i: integer;
			begin
				for i:= 1 to 7 do
					begin
						write(ref_objeto_fila_baralho_cortado.vFilaBaralho[i].peso,' - ');
						write(ref_objeto_fila_baralho_cortado.vFilaBaralho[i].numero,' - ');
						write(ref_objeto_fila_baralho_cortado.vFilaBaralho[i].naipe,' ');
						writeln
					end;						
			end;
		
		procedure escreverCartasComputador(ref_objeto_cartas_computador: treg_lista_cartas);
			var i: integer;
			begin
				for i:= 1 to 3 do
					begin
						write(ref_objeto_cartas_computador.vListaCartasMao[i].peso,' - ');
						write(ref_objeto_cartas_computador.vListaCartasMao[i].numero,' - ');
						write(ref_objeto_cartas_computador.vListaCartasMao[i].naipe,' ');
						writeln;
					end;
			end;
				  							

Begin
	preencherBaralho(objetoBaralho);
	objetoJogo.pontuacaoJogador:=0;
	objetoJogo.pontuacaoComputador:=0;
	writeln('---------------------------------------------------------------------------------------------------------------------');    
	writeln('O jogo vai começar!');
	writeln('---------------------------------------------------------------------------------------------------------------------');     
	writeln('Informe quem irá embaralhar? [1] jogador, [2] computador');
	readln(objetoJogo.embaralhamento);
	writeln('---------------------------------------------------------------------------------------------------------------------');  
	repeat
		embaralhar(objetoBaralho, objetoPilhaBaralho);
		cortar(objetoPilhaBaralho, objetoFilaBaralhoCortado, objetoJogo);
		writeln('---------------------------------------------------------------------------------------------------------------------');    
		trataManilha(objetoFilaBaralhoCortado);
		darAsCartas(objetoCartasJogador, objetoCartasComputador, objetoFilaBaralhoCortado, objetoJogo);
		
	  objetoJogo.pontuacaoJogadorMao:= 0;
		objetoJogo.pontuacaoComputadorMao:= 0;
		objetoJogo.quantidadeCartasJogadas:= 0;
		objetoJogo.contadorEmpachado:= 0;
		objetoJogo.numeroCartasJogador:= 3;
		objetoJogo.numeroCartasComputador:= 3;
		escreverCartasJogador(objetoCartasJogador, objetoJogo);;
		write('A carta virada foi a carta ',objetoFilaBaralhoCortado.vFilaBaralho[7].numero,' de ');
		writeln(objetoFilaBaralhoCortado.vFilaBaralho[7].naipe,' Logo, ');
		escreveCoringa(objetoFilaBaralhoCortado);
		writeln('---------------------------------------------------------------------------------------------------------------------');     
		if objetoJogo.embaralhamento mod 2 = 0 then
			objetoJogo.vez:= true // Se o computador embaralhou e deu as cartas, o jogador que joga a primeira vez
		else                                                                    
			objetoJogo.vez:= false;
		objetoJogo.trucado:= false;
		objetoJogo.pontuacaoTrucado:= 0;
		objetoJogo.correu:= false;
				
		repeat // Cada mão do jogo
			decisao(objetoJogo);
	    if objetoJogo.quantidadeCartasJogadas = 2 then // Se foi jogado duas cartas
	    	begin
	    		objetoJogo.QuantidadeCartasJogadas:= 0;
	    		if not objetoJogo.correu then // Só chama o procedimento decidePonto se ninguém tiver corrido
	    			decidePonto(objetoJogo);	
	    	end;
	
		until (objetoJogo.pontuacaoJogadorMao > 1) or (objetoJogo.pontuacaoComputadorMao > 1) or (objetoJogo.contadorEmpachado = 3);
		objetoJogo.embaralhamento:= objetoJogo.embaralhamento+1;
		decidePontuacao(objetoJogo);
		write('Placar: ');
		writeln('Jogador ',objetoJogo.pontuacaoJogador,' X ',objetoJogo.pontuacaoComputador,' Computador');
		writeln('---------------------------------------------------------------------------------------------------------------------');  
		
	until (objetoJogo.pontuacaoJogador>=12) or (objetoJogo.pontuacaoComputador>=12);
	
	if objetoJogo.pontuacaoJogador>=12 then
		writeln('Você venceu o jogo')
	else
		writeln('Você perdeu o jogo');	       
End.












