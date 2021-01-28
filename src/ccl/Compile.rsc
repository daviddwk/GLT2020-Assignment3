module ccl::Compile

import AST;

public str compile(str name, Controller ctl) =
       "public class <name> {
       '  public static void main(String args[]) throws java.io.IOException { 
       '     new <name>().run(new java.util.Scanner(System.in), 
       '                    new java.io.PrintWriter(System.out));
       '  }
       '  <states2consts(ctl.states)>
       '  <controller2run(ctl)>
       '  <for (e <- ctl.events) {>
  	   '  <event2java(e)>
  	   '  <}>
  	     '  <for (c <- ctl.commands) {>
  	     '  <command2java(c)>
  	     '  <}>
  	     '}";

public str states2consts(list[State] states) {
  i = 0;
  return "<for (s <- states) {>
         'private static final int <stateName(s)> = <i>;
         '<i += 1;}>"; 
}

public str command2java(Command command) =
         "private void <command.name>(java.io.Writer output) throws java.io.IOException {
         '  output.write(\"<command.token>\\n\");
         '  output.flush();
         '}";

public str event2java(Event event) =
         "private boolean <event.name>(String token) {
         '  return token.equals(\"<event.token>\");
         '}";


public str controller2run(Controller ctl) =
         "public void run(java.util.Scanner input, java.io.Writer output) throws java.io.IOException {
         '  int state = <stateName(ctl.states[0])>;
         '  while (true) {
         '    String token = input.nextLine();
         '    switch (state) {
         '      <for (s <- ctl.states) {>
         '      <state2case(s)>
         '      <}>
         '    }
         '  }
         '}";

public str state2case(State s) =
         "case <stateName(s)>: {
         '  <for (a <- s.actions) {>
         '     <a>(output);
         '  <}>
         '  <for (transition(e, s2) <- s.transitions) {>
         '  if (<e>(token)) {
         '     state = <stateName(s2)>;
         '  }
         '  <}>
         '  break;
         '}";

public str stateName(State s) = stateName(s.name);
public str stateName(str s) = "state$<s>";
