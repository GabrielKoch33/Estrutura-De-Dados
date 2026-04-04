Program truco;
	 type
	 
	  cartas = record
			naipe_peso: integer; //paus = 4; copas = 3; espadas = 2; ouros = 1;
			numero_carta: integer	//1,2,3,4,5,6,7,10,11,12	
	 	end;
	 	
	 	computador = record
	  	mao_comp: array [1..3] of cartas;
			pontos_computador: integer;	
		end;
		
	 	pessoa = record
	 		mao_player: array [1..3] of cartas;
			pontos_player: integer;
	
		end;
		
		jogo = record
			player_computador: computador;
			player_jogador: pessoa;
			molde_cartas: cartas; 
			baralho: array [1..40] of cartas;
			baralho_cortado: 	
			aux: cartas;
			start: boolean;
		end;
			
		var
		desc_jogo: jogo;
		k: integer;
		
		procedure popular_baralho(var dc_jogo: jogo);
		var i, naipe, numero: integer;
		begin
			for i:= 1 to 40 do
			begin
				naipe:= (i-1) mod 4 + 1; //1=ouros, 2=espadas, 3=copas, 4=paus
				numero:= (i-1) div 4 + 1; // 1 a 10
																	//grupos de 1 a 10, no grupo 1 existem 4 valores de naipes diferentes
				if numero = 8 then 
					numero := 10
				else if numero = 9 then
					numero := 11
				else if numero =10 then
					numero := 12;
				  // ao invés de pular o 8 e 9, preenche de os valores numericos e dps substitui
				  
				dc_jogo.baralho[i].naipe_peso := naipe;
				dc_jogo.baralho[i].numero_carta := numero;
			end;
			
		procedure embaralhar( var dc_jogo: jogo);
		var i, random1, random2: integer; 
		begin
		 for i:= 1 to 100 do//permite diversas combinações
			 begin
		 		random1:= random(40)+1;
		 		random2:= random(40)+1;
		 		
		 		dc_jogo.aux.naipe_peso := dc_jogo.baralho[random1].naipe_peso;
				dc_jogo.aux.numero_carta := dc_jogo.baralho[random1].numero_carta;
				//swap de cartas
		 		dc_jogo.baralho[random1].naipe_peso:= dc_jogo.baralho[random2].naipe_peso;
				dc_jogo.baralho[random1].numero_carta := dc_jogo.baralho[random2].numero_carta;
				 
		 		dc_jogo.baralho[random2].naipe_peso:= dc_jogo.aux.naipe_peso;
				dc_jogo.baralho[random2].numero_carta := dc_jogo.aux.numero_carta; 
		 	end;
		 	{o write meramente auxiliar, comentar bloco dps}
		 	for i:= 1 to 40 do
		    begin
		   	  write(' [',dc_jogo.baralho[i].naipe_peso, '|');
		   	  write(dc_jogo.baralho[i].numero_carta, '] ');
		   	end;
		end;  
		
		function corte_baralho(dc_jogo: jogo): 		   
		
Begin
    popular_baralho(desc_jogo);
    writeln('------------------------------------');
    writeln('Quem vai embaralhar?');
		writeln('[0] = Computador | [1] = Player');
    readln(desc_jogo.start)//start vai ajudar a definir o fluxo das rodadas e cortes
    			embaralhar (desc_jogo);//independente de quem for o embaralhamento ocorre
    baralho_cortado:= corte_baralho(desc_jogo);
    {A fazer:
		 Quem não embaralhou é quem corta
		 Se computador corta ? random define o índice
		 Se player corta ? readln com validação
		 Range do corte: >= 2 e <= 33
		 Guardar o índice do corte no desc_jogo
		 Quem embaralhou distribui
		 Distribuição começa em corte + 1 (princípio de fila)
		 Manter marcador de posição (ponteiro de início da fila)
		 Distribuir intermitentemente: player ? comp ? player ? comp ? player ? comp
		 Contador de cartas dadas para até 6
		 baralho[corte + 7] ? vira (primeira carta após as 6 distribuídas)
		}
    

End.