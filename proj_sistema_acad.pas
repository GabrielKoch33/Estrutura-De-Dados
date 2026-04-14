Program Pzim ;     //sistema escolar

	CONST weeklyClass = 15;
	CONST tot_notas = 10;
	{máximo de 15 aulas por semana
	teve que ser declarado const pois o weekly é variavel, mas antes de deixar o user definir,
	é preciso declarar um valor}
	type
		mat_nota = record
		disciplina: string;
		nota: array [1..tot_notas] of real; {max 10  notas }
		peso: array [1..tot_notas] of real; {max 10 notas }  
		qtdNotasPorMat: integer;
		somaDosPesos: real;
		media: real;
	end;
		
	sistema = record
		ListaDiscNota: array [1..weeklyClass] of mat_nota;//cada [i] possui o nome de uma disciplina e um campo de x notas //TUDO será inserido nesse vetor ;
		PesoNotas: real;
		pointer_materia: integer;
		pointer_nota: integer;
		pointer_peso: integer;
		qtd_notas: integer;   //inutil?
		qtd_mat: integer;
		media_instituicao: real;
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
						dc.qtd_mat:= dc.qtd_mat + 1;  
			end
		else 
			begin
				  writeln('Qual o nome da ',dc.pointer_materia,'ª matéria?');
					readln(inserir);
					dc.ListaDiscNota[dc.pointer_materia].disciplina:= upcase(inserir);
					dc.pointer_materia := dc.pointer_materia + 1; //define o indice que será incluido uma matéria nova, até um limite definido pelo user
					dc.ListaDiscNota[dc.pointer_materia].qtdNotasPorMat := 0; 
      end;
end;
		
procedure cadastrar_nota(var dc: sistema);
	 	var i,j: integer; inserir,continuar: string;
Begin
		Writeln('LEMBRETE: PERMITIDO CADASTRAR/PUBLICAR NO MÁXIMO ATÉ 10 NOTAS POR MATÉRIA!!!');
		writeln('Você quer cadastrar a nota de qual disciplina?');
		readln(inserir);
		for i:= 1 to dc.qtd_mat do  //percorre todas as matérias cadastradas até achar uma posição em que disciplina = inserir                      
		begin
				if upcase(inserir) = dc.ListaDiscNota[i].disciplina then
					 begin   
							 j:= dc.ListaDiscNota[i].qtdNotasPorMat;  
					   	 while (j <= 10) and (continuar = 'SIM') do
					     begin
							  	writeln('Informe a ',j,'ª Nota e seu respectivo Peso: ');
							  	readln (dc.ListaDiscNota[i].nota[j]);
									readln (dc.ListaDiscNota[i].peso[j]); 
									dc.ListaDiscNota[i].qtdNotasPorMat := dc.ListaDiscNota[i].qtdNotasPorMat + 1;
									writeln('Deseja continuar inserindo notas?');
									readln(continuar);
										if upcase(continuar) = 'SIM' then 
											j:= j + 1;
							end;		
				  end;		
		end;      
end;
		
function relatorio(dc:sistema):integer;
var i: integer;
begin
	Writeln(' RELATÓRIO NOTAS CADASTRADAS... ');
	Writeln(' | MATÉRIA | NOTA ( PESO ) | MÉDIA ATUAL | MÉDIA FALTANTE | ');
	for i:= 1 to dc.pointer_materia-1 do
		begin
			writeln('| ',dc.ListaDiscMat[i].disciplina);
			for j:= 1 to 
		end;
end;
	
	
	
	
		
{procedure remover_disc(var dc:sistema);
	var i: integer; inserir: string;
begin	      
	writeln('nn');
end;

procedure remover_nota(var dc:sistema);
	var i: integer; inserir: string;			
begin
  writeln('nn');
end;
		
		        }
Begin
  op:= 10;
  desc.pointer_materia:= 1;
  desc.qtd_notas:=1;
  writeln('Olá, qual seu nome?');
  readln(nome);
  writeln('Quantas matérias vão ser cadastradas?');
  readln(desc.qtd_mat);{todos os for vão ser percorridos até essa distância} {qtd_mat substitui weeklyclass}
  writeln('Qual a média da Instituição? ');
  readln(desc.media_instituicao);
  writeln('BEM VINDO, ',upcase(nome),' AO SISTEMA DE GERENCIAMENTO DE NOTAS ACADÊMICAS');
  
  while op <> 0 do
  begin
  	   writeln('/// PROGRAMA INICIALIZADO...MENU: \\\');
  	   WRITELN('1 - CADASTRAR DISCIPLINA');               
  	   WRITELN('2 - CADASTRAR NOTA DA DISCIPLINA');
  	   WRITELN('3 - CONSULTAR RELATÓRIO | DISCIPLINA | NOTA | PESO |');
  	   WRITELN('4 - REMOVER/ALTERAR DISCIPLINA ');
  	   WRITELN('5 - REMOVER/ALTERAR NOTA');
  	   WRITELN('0 - SAIR');
  	   writeln('Qual a pedida meu consagrado?');
  	   readln(op);
  	   if op = 1 then
  	  		cadastrar_disciplina(desc);
			 if op = 2 then
			 		cadastrar_nota(desc);
			{ if op = 3 then
					relatorio(desc);
			 if op = 4 then
			 		remover_disciplina(desc);
			 if op = 5 then
			 		remover_nota(desc);}  
			 if op = 0 then
			 		break;
  end;
End.
