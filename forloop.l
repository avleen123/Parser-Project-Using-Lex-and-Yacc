/* This is a lexer file that generates tokens for a C-like programming language. The code starts 
with %{ and %}, which are used to enclose C code to be copied verbatim into the generated lexer
code. The #include directive is used to include the header file y.tab.h, which contains the 
definitions of the tokens.

The next section defines some regular expressions and macros that will be used to match the 
tokens. The regular expression Knostar matches any character that is not an asterisk (*), and 
Pstar matches one or more asterisks. The regular expression id matches any letter or underscore,
and digit matches any digit.

The %{ and %} delimiters are used to start and end the rules section. The rules define the 
regular expressions for the tokens and the actions to be taken when a token is found. Each rule 
consists of a regular expression and an action. The regular expression is matched against the 
input, and when a match is found, the corresponding action is executed. The return statement is 
used to return the token value associated with the matched regular expression.

The first rule matches whitespace and newline characters and ignores them. The second rule 
matches multiline comments and ignores them. The third rule matches single-line comments and 
ignores them. The rest of the rules match the different tokens in the language, such as 
keywords (for, continue, break, int, etc.), identifiers (sequences of letters, digits, and 
underscores), comparison operators (<, >, <=, >=, ==, and !=), logical operators (|| and &&), 
and numbers (sequences of digits). The last rule matches any other character that doesn't match 
any of the previous regular expressions.

The yywrap() function is used to indicate when the end of the input has been reached. 
In this case, it always returns 1.

Overall, this code is a lexer that matches regular expressions to tokens in a C-like programming 
language. It is part of a larger program that includes a parser to generate an abstract syntax 
tree from the tokens. */




%{

    #include <stdio.h> 
	#include "y.tab.h"                  // Including the header file with token definitions
//extern int yylval;
%}

/* Regular expressions and macros for tokens */
Knostar [^*]*
Nostarfwd [^*/]
Pstar [\*]+
id [A-Za-z_]
digit [0-9]
reserved int|float|double|char|long|size_t

/* Ignore whitespace and newlines */

%%

[\t\n\ ]               ;
"/*"{Knostar}{Pstar}({Nostarfwd}{Knostar}{Pstar})*"/" ;   //Multiline comments
"//".* ; //Single line comments
for                         return FOR;         /* Token definitions */
continue                    return CONTINUE;
break                       return BREAK;
exit                        return EXIT;
{reserved}                  return RESERVED;
{digit}+                    return NUM;
{id}({id}|{digit})*         return ID;
"<"                         return LT;
">"                         return GT; 
"<="                        return LE; 
">="                        return GE;
"=="                        return EQ;
"!="                        return NE;
"||"                        return OR;
"&&"                        return AND;
{digit}+("++"|"--")|("++"|"--"){digit}+ printf("lvalue is required as operand");
.                            {return yytext[0];}
%%


int yywrap()
{
    return 1;
}