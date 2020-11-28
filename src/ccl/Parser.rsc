module ccl::Parser

import ParseTree;
import ccl::Syntax;


 /*
 * Define the parser for the CCL language. The name of the function must be parserCCL. 
 * This function receives as parameter the path of the file to parse represented as a loc, and returns a parse tree that represents the parsed program.
 */
 
 public Program parserCCL(loc l) = parse(#Program, l);