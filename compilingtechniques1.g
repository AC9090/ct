grammar small-C;

options {
	language = java;
	
	output = AST;
	
}

tokens{
	PLUS = '+' ;
	MINUS = '-' ;
	MULT = '*' ;
	DIV = '/' ;
	GREATEREQ = '>=' ;
	LESSEQ = '<=' ;
	GREATER = '>'
	LESS = '<' ;
	NOTEQ = '!=' ;
	LEQ = '==' ;
	ENDL = ';' ;
	MOD = '%' ;
	
	WHILE = 'while' ;
	IF = 'if' ;
	ELSE = 'else' ;
	READ = 'read' ;
	OUTPUT = 'output' ;
	PRINT = 'print' ;
	RETURN = 'return'
	READC = 'readc' ;
	OUTPUTC = 'outputc' ;
	
	LPARENT = '(' ;
	RPARENT = ')' ;
	LBRACKET = '[' ;
	RBRACKET = ']' ;
	LCURLY = '{' ;
	RCURLY = '}' ;
	
	INT = 'int' ;
	CHAR = 'char' ;
	
}
	

	
}
/*---------------------PARSER-RULES--------------------*/

stmt	: LCURLY stmtlist RCURLY
	| WHILE LPARENT exp RPARENT stmt
	| IF LPARENT exp RPARENT stmt (ELSE stmnt | )
	| ident EQ lexp ENDL
	| READ LPARENT ident RPARENT ENDL
	| OUTPUT LPARENT ident RPARENT ENDL
	| PRINT LPARENT string RPARENT ENDL
	| RETURN ( lexp | ) ENDL
	| READC LPARENT ident RPARENT ENDL
	| OUTPUTC LPARENT ident RPARENT ENDL
	| ident LPARENT ident ( ',' ident)* RPARENT ENDL
	;

exp	: lexp (GREATER | LESS | GREATEREQ | LESSEQ | NOTEQ | LEQ) lexp
	| lexp
	;

lexp 	: term ((PLUS | MINUS) term | )
	;
	
term 	: factor (DIV | MULT | MOD ) factor
	;

factor 	: LPARENT lexp RPARENT
	| ( MINUS | ) (number | ident)
	| character
	| ident LPARENT ident (',' ident)* RPARENT
	;

/*---------------------LEXER-RULES---------------------*/

IDENT : ALPHA CHARACTER;

STRING : '"' (CHARACTER | WS -> channel(0) ('\n'! WS ) )* '"' ; //catch newline character

CHARACTER : ~ ; //include all keyboard strokes apart from what?

fragment ALPHA : 'A'..'Z' | 'a'..'z' ;

fragment ESCAPE :  '\t' | '\\' | '\'' ; //add end of file

NUMBER : (DIGIT)+ ;

fragment DIGIT : '0'..'9' ;

WS  :  (' '|'\r'|'\t'|'\u000C'|'\n') -> channel(HIDDEN) ;

COMMENT : '/*' .* '*/' -> skip ;
LINE_COMMENT : '//' (~('\n'))* '\n' -> skip ;


