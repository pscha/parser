%top{
#include <stdio.h>
#include "minako.h"
}

%option   	yylineno
%option 	noyywrap
%option		nounput

%x COMMENT

KW_BOOLEAN 	bool
KW_DO 		do
KW_ELSE 	else
KW_FLOAT 	float
KW_FOR 		for
KW_IF 		if
KW_INT 		int
KW_PRINTF 	printf
KW_RETURN 	return
KW_VOID 	void
KW_WHILE 	while

PLUS 		+
MINUS 		-
ASTERISK 	*
SLASH 		/
ASSIGN 		=
EQ 		==
NEQ 		!=
LSS 		<
GRT 		>
LEQ 		<=
GEQ 		>=
AND 		&&
OR 		||

COMMA		,
SEMICOLON	;
LPAREN		(
RPAREN		)
LBRACE		{
RBRACE		}

CONST_INT 	{INTEGER}
CONST_FLOAT 	{FLOAT} ( [eE] ([-+])? {INTEGER} )? | {INTEGER} [eE] ([-+])? {INTEGER}
CONST_BOOLEAN 	true | false
ID 		({LETTER})+ ({DIGIT} | {LETTER})*

DIGIT 		[0-9]
INTEGER 	{DIGIT}+
FLOAT 		{INTEGER} "." {INTEGER} | "." {INTEGER}
LETTER 		[a-zA-Z]



yylineno = 1; 
%%

"//".*

"/*"            { BEGIN(COMMENT); }
<COMMENT>"*/" { BEGIN(INITIAL); }
<COMMENT>.|\n    {}

bool	return(KW_BOOLEAN);
do	return(KW_DO);
else	return(KW_ELSE);
float	return(KW_FLOAT);
for	return(KW_FOR);
if	return(KW_IF);
int	return(KW_INT);
printf	return(KW_PRINTF);
return	return(KW_RETURN);
void	return(KW_VOID);
while	return(KW_WHILE);

"+"	return('+');
"-"	return('-');
"*"	return('*');
"/"	return('/');
"="	return('=');
"=="	return(EQ);
"!="	return(NEQ);
"<="	return(LEQ);
">="	return(GEQ);
"<"	return(LSS);
">"	return(GRT);
"&&"	return(AND);
"||"	return(OR);
";"	return(';');
","	return(',');
"{"	return('{');
"}"	return('}');
"("	return('(');
")"	return(')');

true	return(CONST_BOOLEAN);
false	return(CONST_BOOLEAN);

({LETTER})+({DIGIT}|{LETTER})*	{yylval.string = yytext; return(ID);}
({DIGIT})+			{yylval.intValue = atoi(yytext); return(CONST_INT);}
([0-9]+"."[0-9]+|"."[0-9]+)([eE]([-+])?[0-9]+)?|[0-9]+[eE]([-+])?[0-9]+	{yylval.floatValue = atof(yytext); return(CONST_FLOAT);}

<<EOF>>	return(EOF);
[ \t]

.	printf("lexical error: word undefined in line %d: %s\n",yylineno, yytext);	
\n

%%

