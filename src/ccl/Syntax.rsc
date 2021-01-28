module ccl::Syntax
 
lexical Id = ([a-zA-Z0-9_] !<< [a-zA-Z][a-zA-Z0-9_]* !>> [a-zA-Z0-9_]);
lexical Value = ([1-9][0-9]*) | [0] ;
lexical Pattern = ( "." | "-" )+;

layout Whitespace = [\t-\n\r\ ]*; 

keyword Bool = "true" | "false";
keyword Heating = "top" | "bottom" | "both";

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
	= TimeSetting timeSet
	| LightSetting lightSet
	| HeatingSetting heatSet
	| TemperatureSetting tempSet
	| FanSetting fanSet
	| VolumeSetting volSet
	| PatternSetting patSet
	| LoopSetting loopSet
	| AlarmSetting alarmSet
	;

syntax TimeSetting
	= "time" "=" Value hours ":" Value minutes ":" Value seconds
	;
	
syntax LightSetting
	= "light" "=" Bool light
	;
	
syntax HeatingSetting
	= "heating" "=" Heating heating
	;
	
syntax TemperatureSetting
	= "temperature" "=" Value temperature
	;
		
syntax FanSetting
	= "fan" "=" Bool fan
	;

syntax VolumeSetting
	= "volume" "=" Value volume
	;
	
syntax PatternSetting
	= "pattern" "=" Pattern pattern
	;
	
syntax LoopSetting
	= "loop" "=" Value loop
	;
	
syntax AlarmSetting
	= "alarm" "=" Id alarm
	;