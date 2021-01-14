module ccl::Syntax
 
lexical Id = ([a-zA-Z0-9_] !<< [a-zA-Z][a-zA-Z0-9_]* !>> [a-zA-Z0-9_]);
lexical Value = ([1-9][0-9]*) | [0] ;

layout Whitespace = [\t-\n\r\ ]*; 

keyword Bool = "true" | "false";

start syntax Program program
	= Preset* presets
	;
	
syntax Preset
	= Alarm alarm
	| Mode mode
	;

syntax Alarm
	= "mode" Id id "{" Settings settings "}"
	;
	
syntax Mode
	= "alarm" Id id "{" Settings settings "}"
	;

syntax Settings
	= Setting setting
	| Setting setting "," Settings settings 
	;
	
syntax Setting
	= TimerSetting timerSet
	| LightSetting lightSet
	| HeatSetting heatSet
	| FanSetting fanSet
	| VolumeSetting volSet
	;

syntax TimerSetting
	= "timer" "=" Value time
	| "timer" "=" "userinput" time
	;
	
syntax LightSetting
	= "light" "=" Bool light
	;
	
syntax HeatSetting
	= "heat" "=" Value heat
	;
		
syntax FanSetting
	= "fan" "=" Bool fan
	;
		
syntax VolumeSetting
	= "volume" "=" Value vol
	;
	