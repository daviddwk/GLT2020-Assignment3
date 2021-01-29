module ccl::Compile

import ccl::Check;
import ccl::AST;

public str compile(str name, AbsProgram prog){
	int error = check(prog);
	// if the checker finds an error than output a java program that describes the error
	if(error != 0){
		return "public class <name> {
        '  public static void main(String args[]) { 
        '     <error2Java(error)>
        '  }
  	    '}";
	}
	// if the checker did not find an error than output the presets
	return "public class <name> {
    '  public static void main(String args[]) throws java.io.IOException { 
    '     new <name>().run();
    '  }
    '  <prog2run(prog)>
  	'}";
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

public str prog2run(AbsProgram prog) =
         "public void run() throws java.io.IOException {
         '	<for (s <- prog.presets) {>
         '		<presets2case(s)>
         '	<}>
         '}";

public str presets2case(AbsPreset s) =
         "System.out.println(\"<presetsName(s)>\");
         '  <for (a <- s.settings) {>
         '		<if (a.settype == "time") {>
         '     		System.out.println(\"<a.settype> = <a.time>\");
         '		<}>
                  '		<if (a.settype == "light") {>
         '     		System.out.println(\"<a.settype> = <a.light>\");
         '		<}>
                  '		<if (a.settype == "heating") {>
         '     		System.out.println(\"<a.settype> = <a.heat>\");
         '		<}>
                  '		<if (a.settype == "temperature") {>
         '     		System.out.println(\"<a.settype> = <a.temperature>\");
         '		<}>
                  '		<if (a.settype == "fan") {>
         '     		System.out.println(\"<a.settype> = <a.fan>\");
         '		<}>
                  '		<if (a.settype == "volume") {>
         '     		System.out.println(\"<a.settype> = <a.volume>\");
         '		<}>
                  '		<if (a.settype == "pattern") {>
         '     		System.out.println(\"<a.settype> = <a.pattern>\");
         '		<}>
                  '		<if (a.settype == "loop") {>
         '     		System.out.println(\"<a.settype> = <a.loop>\");
         '		<}>
         '		<if (a.settype == "alarm") {>
         '     		System.out.println(\"<a.settype> = <a.alarm>\");
         '		<}>
         '  <}>";
         

public str presetsName(AbsPreset s) = presetsName(s.id);
public str presetsName(str s) = "presets$<s>";