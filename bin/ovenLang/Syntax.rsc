module ovenLang::Syntax
 
lexical Id = ([a-zA-Z0-9_] !<< [a-zA-Z][a-zA-Z0-9_]* !>> [a-zA-Z0-9_]);
lexical Value = ([1-9][0-9]*) | [0] ;

layout Whitespace = [\t-\n\r\ ]*; 

keyword Bool = "true" | "false";
keyword Light = "flashing" | "on" | "off";
keyword Buzz = "off" | "sample" | "otherSample";

start syntax Program
	= Preset* presets
	;
	
syntax Preset
	= "mode" presettype Id id "{" Settings settings "}"
	| "alarm" presettype Id id "{" Settings settings "}"
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
	| BuzzerSetting buzzSet
	| AlarmSetting alarmSet
	;

syntax TimerSetting
	= "timer" "=" Value time
	| "timer" "=" "userinput" time
	;
	
syntax LightSetting
	= "light" "=" Light light
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

syntax BuzzerSetting
	= "buzzer" "=" Buzz buzz
	;
	
syntax AlarmSetting
	= "alarm" "=" Id alarm
	;
	