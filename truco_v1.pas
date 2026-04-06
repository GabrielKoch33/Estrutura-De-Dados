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
			baralho: array [1..40] of cartas;
			aux: cartas;
			start: integer;
			corte: integer;
			distribuidor: integer;
		end;
			
		var
		desc_jogo: jogo;
		
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
		
		procedure corte_baralho(var dc_jogo: jogo);
		var i: integer;		   
		begin
			if dc_jogo.start = 1 then   //corte: = indice random + 1;
			begin			 
				 dc_jogo.corte:= random(32)+1;//1 é o mínimo; 33 é máximo. ex: corte na posição 32, as posições 33 para frente vão ser usadas para distruibuir e 'vira'
			   dc_jogo.corte:= dc_jogo.corte+ 1;
			end
			else 
			begin
				 writeln('Qual a posição de corte?');
				 readln(dc_jogo.corte);
				 dc_jogo.corte:= dc_jogo.corte + 1;
				 if dc_jogo.corte < 1 or dc_jogo.corte > 33 then
				 repeat
				 begin
						writeln('Corte Inválido, tente novamente: ');
						readln(dc_jogo.corte);
						dc_jogo.corte:= dc_jogo.corte + 1;
				 end;
				 until dc_jogo.corte > 1 and dc_jogo.corte <= 33;
			end;									 
		end;
		
		procedure distribui_cartas(var dc_jogo: jogo);
		var  i, contador_de_cartas, receba: integer;
		begin
				if dc_jogo.start = 1 then receba := 1;//se comp começa, ent player recebe primeiro	
				if dc_jogo.start = 2 then receba := 2;//se player começa, ent comp recebe primeiro
		  contador_de_cartas:= 0;
		  if receba = 1 then
			begin
			for dc_jogo.[corte] to dc_jogo.[corte+5] do
				begin
         	if contador_de_cartas mod 2 = 0 then
         	begin
         		dc_jogo.jogador_player.mao_player[contador_de_cartas div 2 + 1] := dc_jogo.baralho[corte];
         		contador_de_cartas := contador_de_cartas + 1;
         	end
         	else if contador_de_cartas mod 2 = 1 then
         	begin
         		dc_jogo.jogador_computador.mao_computador[contador_de_cartas div 2 + 1] := dc_jogo.baralho[corte];
         		contador_de_cartas := contador_de_cartas + 1;
         	end;
				end;
			end;
		
			if receba = 2 then
			begin
				for dc_jogo.corte to dc_jogo.corte+5 do
					begin
	         	contador_de_cartas:= 0;
	         	if contador_de_cartas mod 2 = 0 then
	         	begin
	         		dc_jogo.jogador_computador.mao_computador[contador_de_cartas div 2 + 1] := dc_jogo.[corte];
	         	end
	         	else if contador_de_cartas mod 2 = 1 then
	         	begin
	         		dc_jogo.jogador_player.mao_player[contador_de_cartas div 2 + 1] := dc_jogo.[corte];
	         	end;
					end;
			end;			
		end;
		
Begin
		//quem embaralha, distribui tbm
		//quem corta, lança primeiro
	{while desc_jogo.player_computador.pontos_computador < 11 OR desc_jogo.player_jogador.pontos_player < 11 do}
    popular_baralho(desc_jogo);
    writeln('------------------------------------');
    writeln('Quem vai embaralhar?');
		writeln('[1] = Computador | [2] = Player');
	embaralhar(desc_jogo);
   		readln(desc_jogo.start)//start vai ajudar a definir o fluxo das rodadas e cortes
    corte_baralho(desc_jogo);
    distribui_cartas(desc_jogo);
End.

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
    
