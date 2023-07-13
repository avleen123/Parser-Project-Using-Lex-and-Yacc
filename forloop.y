/* This is a flex and bison (GNU yacc) code for a basic C-like language parser. Here is a brief 
documentation of the code:

The first part of the code contains C preprocessor directives and declarations, including:

#include <stdio.h> and #include <stdlib.h> to include standard C libraries.
int yylex() and int yyerror() function declarations, which are used to perform lexical analysis
and error handling.

extern FILE *yyin and extern FILE *yyout declarations, which are used to read input from a file 
and write output to a file.

The %token section STARTFORines the tokens used in the language. These tokens are used by the parser 
to recognize the input. Tokens in this code include ID for identifiers, NUM for numbers, and 
FOR, LE, GE, EQ, NE, OR, AND, CONTINUE, BREAK,EXIT and RESERVED for keywords.

The %right, %left, and %precedence sections STARTFORine the operator precedence of the language. 
Operators with higher precedence are parsed first. For example, %left '+' '-' defines that the 
+ and - operators have left associativity, which means that the expression a+b-c is equivalent 
to (a+b)-c. The %right '=' declaration defines that the = operator has right associativity.

The %% section contains the grammar rules for the language. The grammar includes rules for statements (START), loops (LOOP), 
definitions (STARTFOR), expressions for initilization (EXPR),expressions for condition (CONDITION) and expressions for increement/deecrement (EXPR2).

The yyerror function is called when an error occurs during parsing. It prints an error message 
and exits the program.

The main function opens the input file specified in the command-line arguments, calls yyparse() 
to begin parsing, and opens a result file for writing the output.

In summary, this code defines a grammar for a basic C-like language and uses flex and bison to 
perform lexical analysis and parsing. It is meant to demonstrate how to write a simple parser 
for a programming language. */




%{
// Header section: includes and declarations
#include <stdio.h>
#include <stdlib.h>

// Function declarations
int yylex();
int yyerror();
extern FILE *yyin;
extern FILE *yyout;
%}

// Token definitions
%token ID NUM FOR LE GE EQ NE OR AND CONTINUE BREAK EXIT RESERVED 

// Operator precedence and associativity
%right '='
%left  OR AND
%left  LE GE EQ NE LT GT
%left '+' '-'
%left '*' '/'
%left '!' '%'
%left ','

// Start symbol
%%

START    : LOOP {printf("FOR Syntax ACCEPTED \n"); exit(0);}

// Grammar rules
LOOP          : FOR '(' EXPR ';' CONDITION ';' EXPR2')' STARTFOR
            | FOR '(' ';'  ';' ')' STARTFOR
            | FOR '(' EXPR ';'  ';' ')' STARTFOR
            | FOR '(' ';'CONDITION  ';' ')' STARTFOR
            | FOR '(' ';'  ';' EXPR2 ')' STARTFOR
		|FOR '(' ';' CONDITION ';' EXPR2 ')' STARTFOR
		|FOR '('EXPR ';'  ';' EXPR2 ')' STARTFOR
		|FOR '('EXPR ';' CONDITION ';'  ')' STARTFOR
            ;
            

STARTFOR   : ';'
	     |'{' '}'
           | '{' BODY '}'
           | EXPR ';'
           | LOOP
           | ID ID ';'
           ;

BODY  	: BODY LOOP
           | BODY EXPR  ';'     
           | LOOP
           | EXPR ';'
           | BREAK ';'
           | CONTINUE ';'
           |EXIT ';'   
           | ID ID ';'
           |';'   
           | BODY BREAK ';'
           | BODY CONTINUE ';'
           | BODY EXIT ';' 
	     ;
       
EXPR      : ID '=' EXPR
	    |EXPR ',' EXPR	
          |RESERVED ID '=' EXPR
          | EXPR '+' EXPR
          | EXPR '-' EXPR 
          | EXPR '*' EXPR 
          | EXPR '/' EXPR  
          | EXPR '%' EXPR 
          | ID 
          | NUM
          ;

   
CONDITION :ID '=' EXPR
          | CONDITION LT CONDITION
          | CONDITION GT CONDITION
          | CONDITION LE CONDITION
          | CONDITION GE CONDITION
          | CONDITION EQ CONDITION
          | CONDITION NE CONDITION
          | CONDITION OR CONDITION
          | CONDITION AND CONDITION
          |NUM
	    |CONDITION ','CONDITION
          |ID
          ;
   
EXPR2   :ID '=' EXPR 
        |EXPR2 ',' EXPR2	
	  | ID '+' '+' 
        | ID '-' '-'
        | '+' '+' ID 
        | '-' '-' ID
        ;
%%

// Error handling function
int yyerror(char const *s)
{
    printf("\nyyerror  %s\n",s);
    exit(1) ;
}

// Main function
int main(int argc,char **argv) {
    yyin = fopen(argv[argc-1],"r"); // Open input file for reading
    yyparse(); // Call parser function

} 