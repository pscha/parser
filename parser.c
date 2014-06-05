#include <stdio.h>
#include <stdlib.h>
#include "minako.h"

yystype yylval;

void term(){

	return();
	
}


int main(int argc, char** argv){
	
	int token;

	/* if no input file is defined */
	if(argc != 2){
		/* use stdin as input */
		yyin = stdin;	
	}
	else{
		/* else open the file if possible */
		yyin = fopen(argv[1],"r");
		if(!yyin){
                       fprintf(stderr, "Fehler: Konnte Datei %s nicht zum lesen oeffnen.\n", argv[1]);
		       exit(-1);
		}
	}

	if((token = yylex()) != "("){
	
		

	}
	return(0);
}
