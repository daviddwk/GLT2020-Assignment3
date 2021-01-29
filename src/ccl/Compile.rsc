module ccl::Compile

import ccl::Check;
import ccl::AST;

public str compile(str name, AbsProgram prog) {
	int error = check(prog);
	if(error != 0){
		return "public class <name> {
        '  public static void main(String args[]) { 
        '     <error2Java(error)>
        '  }
  	    '}";
	} else {
		return "public class <name> {
        '  public static void main(String args[]) throws java.io.IOException { 
        '     new <name>().run(new java.util.Scanner(System.in), 
        '                    new java.io.PrintWriter(System.out));
        '  }
        '  <presets2consts(prog.presets)>
        '  <prog2run(prog)>
  	    '}";
	}
}

public str error2Java(int error){
		str errorMessage = "";
		if(error == 1){
			errorMessage = "Error(1): Reused label.";
		}else if(error == 2){
			errorMessage = "Error(2): Missing or invalid mode setting.";
		}else if(error == 3){
			errorMessage = "Error(3): Missing or invalid alarm setting.";
		}else if(error == 4){
			errorMessage = "Error(4): Missing or invalid alarm setting.";
		}else if(error == 5){
			errorMessage = "Error(5): Multiple presets with the same configuration.";
		};
		return "System.out.println(\"<errorMessage>\");";
}

public str presets2consts(list[AbsPreset] pre) {
  i = 0;
  return "<for (s <- pre) {>
         'private static final int <presetsName(s)> = <i>;
         '<i += 1;}>"; 
}

public str prog2run(AbsProgram prog) =
         "public void run(java.util.Scanner input, java.io.Writer output) throws java.io.IOException {
         '  int preset = <presetsName(prog.presets[0])>;
         '  while (true) {
         '    String token = input.nextLine();
         '    switch (preset) {
         '      <for (s <- prog.presets) {>
         '      <presets2case(s)>
         '      <}>
         '    }
         '  }
         '}";

public str presets2case(AbsPreset s) =
         "case <presetsName(s)>: {
         '  <for (a <- s.settings) {>
         '     <a>;
         '  <}>
         '  break;
         '}";

public str presetsName(AbsPreset s) = presetsName(s.id);
public str presetsName(str s) = "presets$<s>";
