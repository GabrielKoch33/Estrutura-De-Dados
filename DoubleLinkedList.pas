Program dicionarioBastos ;

type:
    	tipo_inf = string;
    	ptLista = ^lista;// permite apontar para palavras-chaves anteriores e posteriores
    	ptDict = ^dicionario; //permite apontar de palavras-chaves para dicionário como de dict -> dict
    	
type:	lista = record
    		palavra_chave: string;  // CARRO - MELHOR (vamos deixar as palavras chaves em .upper()?)
    		ant: ptLista; 
    		prox: ptLista;
    		dict: ptDict;
    			
type: dicionario = record
    		palavraPTBR: string;
    		palavraING: string;
    		dc_prox: ptDict;
    
type descritor = record
		  
Begin
    	
End.
