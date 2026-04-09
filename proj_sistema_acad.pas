Program Pzim ;     //sistema escolar

	CONST weeklyClass = 15;
	CONST tot_notas = 6;
	{máximo de 15 aulas por semana
	teve que ser declarado const pois o weekly é variavel, mas antes de deixar o user definir,
	é preciso declarar um valor}
	type 
		mat_nota = record
			disciplina: string;
			nota: array [1..tot_notas] of real;
			peso: array [1..tot_notas] of real;
		end;
		
	{	sist_acad = record
			 lista: array [1..weeklyClass] of mat_nota//cada [i] possui o nome de uma disciplina e um campo de x notas
		end; //TUDO será inserido nesse vetor
	}
		sistema = record
			ListaDiscNota: array [1..weeklyClass] of mat_nota//cada [i] possui o nome de uma disciplina e um campo de x notas //TUDO será inserido nesse vetor ;
			PesoNotas: real;
			pointer_materia: integer;
			qtd_notas: integer;
			qtd_mat: integer;
			limite: string;
		end;
		
		var
			desc: sistema;
			op: integer;
			nome: string;
			
		
		procedure cadastrar_disciplina(var dc: sistema);
			var i: integer; inserir: string;
		begin
			
				if dc.pointer_materia > dc.qtd_mat then
					begin
					  writeln('LIMITES DE MATÉRIAS CADASTRADAS ALCANÇADAS, DESEJA AUMENTAR O LIMITE DE CADASTROS? DIGITE "SIM" OU "NÃO"');
					  readln(dc.limite);
					  if upcase(dc.limite) = 'SIM' then
					  begin
					  	dc.qtd_mat:= dc.qtd_mat + 1;
							dc.pointer_materia:= dc.pointer_materia + 1; 
					  end;
					end
				else 
					begin
					  writeln('Qual o nome da ',dc.pointer_materia,'ª matéria?');
						readln(inserir);
						dc.ListaDiscNota[dc.pointer_materia].disciplina:= inserir;
						dc.pointer_materia := dc.pointer_materia + 1;
          end;
		end;
			
		procedure cadastrar_nota(var dc: sistema);
		 	var i: integer; inserir: string;
		Begin
		      writeln('Você quer cadastrar a nota de qual disciplina?');
					readln(inserir);
					for i:= 1 to qtd_mat do
						begin
						    if //inserir = a [i] then adiciona nota e soma pesos
						end;      
		end;
		
		function relatorio(dc:sistema):string;
		begin
			  
		end;
		
		procedure remover_disc(var dc:sistema);
		var i: integer; inserir: string;
		begin
		      writeln('nn');
		end;
		
		procedure remover_nota(var dc:sistema);
		var i: integer; inserir: string;			
		begin
		     writeln('nn');
		end;
		
		
Begin
  op:= 10;
  desc.pointer_materia:= 1;
  desc.qtd_notas:=1;
  writeln('Olá, qual seu nome?');
  readln(nome);
  writeln('Quantas matérias vão ser cadastradas?');
  readln(desc.qtd_mat);{todos os for vão ser percorridos até essa distância}
  writeln('BEM VINDO, ',upcase(nome),' AO SISTEMA DE GERENCIAMENTO DE NOTAS ACADÊMICAS');
  while op <> 0 do
  begin
  	   writeln('/// PROGRAMA INICIALIZADO...MENU: \\\');
  	   WRITELN('1 - CADASTRAR DISCIPLINA');               
  	   WRITELN('2 - CADASTRAR NOTA DA DISCIPLINA');
  	   WRITELN('3 - CONSULTAR RELATÓRIO | DISCIPLINA | NOTA |');
  	   WRITELN('4 - REMOVER/ALTERAR DISCIPLINA DISCIPLINA');
  	   WRITELN('5 - REMOVER/ALTERAR NOTA');
  	   WRITELN('0 - SAIR');
  	   writeln('Qual a pedida meu consagrado?');
  	   readln(op);
  	   if op = 1 then
  	  		cadastrar_disciplina(desc);
			 if op = 2 then
			 		cadastrar_nota(desc);
			 if op = 3 then
					relatorio(desc);
			 if op = 4 then
			 		remover_disciplina(desc);
			 if op = 5 then
			 		remover_nota(desc);  
			 if op = 0 then
			 		break
			 else
			 		writeln('OPÇÃO INVÁLIDA, TENTE NOVAMENTE'); 
  end;
  
End.