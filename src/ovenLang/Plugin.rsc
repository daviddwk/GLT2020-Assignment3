module ovenLang::Plugin

import util::IDE;
import ovenLang::Parser;
import ParseTree;
import ovenLang::CST2AST;
import ovenLang::Check;

/*
* This is the main function of the project. This function enables the editor's syntax highlighting.
* After calling this function from the terminal, all files with extension .oven will be parsed using the parser defined in module ovenLang::Parser.
* If there are syntactic errors in the program, no highlighting will be shown in the editor.
*/
void main() {
	registerLanguage("ovenLang", "oven", Tree(str _, loc path) {
		return parser(path);
  	});
}