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
			 		// Armazena quantas cartas tem na mão, como servindo como posição
			 		numeroCartasComputador: integer;
			 		pontuacaoJogadorMao: integer;
			 		pontuacaoComputadorMao: integer;
			 		embaralhamento: integer; // vez de quem embaralha
			 		vez: boolean; // vez de quem joga, se for o jogador é true
			 		quantidadeCartasJogadas: integer; // Quantidade de cartas jogadas por mão
			 		cartaJogador: treg_carta; // Armazena a carta que o jogador jogou
			 		cartaComputador: treg_carta; // Armazena a carta que o computador jogou
			 		contadorEmpachado: integer; // Conta a quantidade de rodadas empachadas
			 		valorMao: integer; 
			 end;
	 
	var i: integer; 
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
			contador:= 1;
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
	 								 var ref_objeto_jogo: treg_jogo);
  	var i, j, posicao_cortado: integer;
  	begin
  		j:= 1;                                    //alterei o mod =1 pq o jogador estava cortando random, e o computador escolhia (invertido)
  		if ref_objeto_jogo.embaralhamento = 2  then // O jogador só corta se o computador embaralhar e dar as cartas
  			repeat
  				writeln('Informe a posicao que você deseja cortar o baralho. (entre 2 e 34)');
  				readln(posicao_cortado);
  			until ((posicao_cortado>1) and (posicao_cortado<=34))
			else	
  			repeat
  				posicao_cortado:= random(40)+1;	
  			until ((posicao_cortado>1) and (posicao_cortado<=34));
  		writeln('A posição que o baralho foi cortado foi: ',posicao_cortado);           //<------------Programa aparentemente parou aqui??
  		for i:= posicao_cortado to 40 do  //Preenchendo a fila com os valores da pilha
  			begin
  				ref_objeto_fila_baralho_cortado.vFilaBaralho[j]:= ref_objeto_pilha_baralho.vPilhaBaralho[i];
  				j:= j+1;
  			end
  	end;
  	
  procedure trataManilha(var ref_fila_baralho_cortado: treg_fila_baralho_cortado);
		var i, determinante_manilhas: integer;
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
  
  procedure darAsCartas(var ref_objeto_cartas_jogador: treg_lista_cartas;
	 											var ref_objeto_cartas_computador: treg_lista_cartas;
												ref_objeto_fila_baralho_cortado: treg_fila_baralho_cortado;
												var ref_objeto_jogo: treg_jogo);
		var i, cont_jogador, cont_computador: integer;
		begin
			cont_jogador:= 1;
			cont_computador:=1;
			ref_objeto_jogo.numeroCartasJogador:= 3; 
			ref_objeto_jogo.numeroCartasComputador:= 3;
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
				for i:= 1 to ref_objeto_jogo.numeroCartasJogador do
					begin
						write(ref_objeto_cartas_jogador.vListaCartasMao[i].peso,' - ');
						write(ref_objeto_cartas_jogador.vListaCartasMao[i].numero,' - ');
						write(ref_objeto_cartas_jogador.vListaCartasMao[i].naipe,' ');
						writeln;
					end;
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
						writeln('Informe qual carta você deseja jogar:');
						escreverCartasJogador(ref_objeto_cartas_jogador, ref_objeto_jogo);
						for i:= 1 to ref_objeto_jogo.numeroCartasJogador do
							begin
								write('[',i,'] ');	
							end;
						readln(posicao_carta);
						carta_escolhida:= ref_objeto_cartas_jogador.vListaCartasMao[posicao_carta];
						if posicao_carta <> ref_objeto_jogo.numeroCartasJogador then
							for i:= posicao_carta to ref_objeto_jogo.numeroCartasJogador-1 do
								ref_objeto_cartas_jogador.vListaCartasMao[i]:= ref_objeto_cartas_jogador.VlistaCartasMao[i+1];
								
						ref_objeto_jogo.numeroCartasJogador:= ref_objeto_jogo.numeroCartasJogador-1;
						ref_objeto_jogo.cartaJogador:= carta_escolhida;
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
						writeln('Computador jogou: ', carta_escolhida.numero, ' de ', carta_escolhida.naipe); 
					end;
				jogarCarta:= carta_escolhida;		   
			end;
			
		function decisao(var ref_objeto_jogo: treg_jogo): integer; // Decisão que o jogador e o computador tomam
			var valor: integer;
			begin
			  
				if ref_objeto_jogo.vez = true then
					begin
						repeat
							writeln('O que você deseja fazer: [1] Jogar carta, [2] Trucar, [3] Aceitar truco, [4] Aumentar truco');
							readln(valor);
						until (valor > 0) and (valor < 5);
					end
				else
						valor:= 1;
				decisao:= valor;		
			end;
			
	procedure decidePonto(var ref_objeto_jogo: treg_jogo);
			begin
				if ref_objeto_jogo.cartaJogador.peso > ref_objeto_jogo.cartaComputador.peso then
					begin
						writeln('Você ganhou a rodada!');
						if ref_objeto_jogo.contadorEmpachado <> 0 then
							ref_objeto_jogo.pontuacaoJogadorMao:= ref_objeto_jogo.pontuacaoJogadorMao + 1 + ref_objeto_jogo.contadorEmpachado
						else
							ref_objeto_jogo.pontuacaoJogadorMao:= ref_objeto_jogo.pontuacaoJogadorMao + 1;
						ref_objeto_jogo.contadorEmpachado:= 0;
					end
				else if ref_objeto_jogo.cartaComputador.peso > ref_objeto_jogo.cartaJogador.peso then
					begin
						writeln('Computador ganhou a rodada!');
						if ref_objeto_jogo.contadorEmpachado <> 0 then
							ref_objeto_jogo.pontuacaoComputadorMao:= ref_objeto_jogo.pontuacaoComputadorMao + 1 + ref_objeto_jogo.contadorEmpachado
						else
							ref_objeto_jogo.pontuacaoComputadorMao:= ref_objeto_jogo.pontuacaoComputadorMao + 1;
						ref_objeto_jogo.contadorEmpachado:= 0;
					end
				else
					begin
						writeln('Empate na rodada!');
						ref_objeto_jogo.contadorEmpachado:= ref_objeto_jogo.contadorEmpachado + 1;
					end;
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
	randomize;
	preencherBaralho(objetoBaralho);
	objetoJogo.pontuacaoJogador:=0;
	objetoJogo.pontuacaoComputador:=0;
	objetoJogo.valorMao:= 1; // mão começa valendo 1 ponto
	writeln('O jogo vai começar!');
	writeln('Informe quem irá embaralhar? [1] jogador, [2] computador');
	readln(objetoJogo.embaralhamento);
	
	repeat // Loop do jogo inteiro
	
		if objetoJogo.embaralhamento mod 2 = 0 then
			objetoJogo.vez:= true
		else
			objetoJogo.vez:= false;
			
		embaralhar(objetoBaralho, objetoPilhaBaralho);
		cortar(objetoPilhaBaralho, objetoFilaBaralhoCortado, objetoJogo);
		trataManilha(objetoFilaBaralhoCortado);
		darAsCartas(objetoCartasJogador, objetoCartasComputador, objetoFilaBaralhoCortado, objetoJogo);
		
		objetoJogo.pontuacaoJogadorMao:= 0;
		objetoJogo.pontuacaoComputadorMao:= 0;
		objetoJogo.quantidadeCartasJogadas:= 0;
		objetoJogo.contadorEmpachado:= 0;
		objetoJogo.valorMao:= 1;
				
		repeat // Loop de cada mão; mao = rodada onde os 2 jogam as 3 cartas			
			if decisao(objetoJogo) = 1 then
				begin
					jogarCarta(objetoCartasJogador, objetoCartasComputador, objetoJogo);
					objetoJogo.quantidadeCartasJogadas:= objetoJogo.quantidadeCartasJogadas + 1;
					
					if objetoJogo.quantidadeCartasJogadas mod 2 = 0 then // a cada 2 cartas jogadas, decide ponto
						begin
							decidePonto(objetoJogo);
							objetoJogo.vez:= not objetoJogo.vez; // inverte vez após cada rodada completa
						end
					else
						objetoJogo.vez:= not objetoJogo.vez; // inverte vez para o próximo jogar
				end;
 
		until (objetoJogo.pontuacaoJogadorMao > 1) or (objetoJogo.pontuacaoComputadorMao > 1) or (objetoJogo.contadorEmpachado = 3);
	
		if objetoJogo.pontuacaoJogadorMao > objetoJogo.pontuacaoComputadorMao then
			begin
				writeln('Você ganhou a mão! +', objetoJogo.valorMao, ' ponto(s)');
				objetoJogo.pontuacaoJogador:= objetoJogo.pontuacaoJogador + objetoJogo.valorMao;
			end
		else if objetoJogo.pontuacaoComputadorMao > objetoJogo.pontuacaoJogadorMao then
			begin
				writeln('Computador ganhou a mão! +', objetoJogo.valorMao, ' ponto(s)');
				objetoJogo.pontuacaoComputador:= objetoJogo.pontuacaoComputador + objetoJogo.valorMao;
			end
		else
			writeln('Mão empatada! Nenhum ponto.');
			
		writeln('Placar — Você: ', objetoJogo.pontuacaoJogador, ' | Computador: ', objetoJogo.pontuacaoComputador);
		
		objetoJogo.embaralhamento:= objetoJogo.embaralhamento + 1;
		
	until (objetoJogo.pontuacaoJogador >= 12) or (objetoJogo.pontuacaoComputador >= 12);
	
	if objetoJogo.pontuacaoJogador >= 12 then
		writeln('Você venceu o jogo!')
	else
		writeln('Você perdeu o jogo!');	
 
End.
