module ovenLang::Parser

import ParseTree;
import ovenLang::Syntax;


 /*
 * Define the parser for the ovenLanguage. The name of the function must be parser. 
 * This function receives as parameter the path of the file to parse represented as a loc, and returns a parse tree that represents the parsed program.
 */
 
 /*parser function for parsing according to ovenLang's concrete syntax*/
 public Program parser(loc l) = parse(#Program, l);