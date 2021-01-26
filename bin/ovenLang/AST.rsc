module ovenLang::AST

 data AbsProgram = absprogram(list[AbsPreset] presets);
 data AbsPreset = abspresetalarm(str id, list[AbsSetting] settings)
 	| abspresetmode(str id, list[AbsSetting] settings)
 	; 
 data AbsSetting = abstime(int time) // time in seconds
 	| abslight(bool light)
 	| absheating(str heat)
 	| abstemperature(int temperature)
 	| absfan(bool fan)
 	| absvolume(int volume)
 	| abspattern(str pattern)
 	| absloop(int loop) // 0 represents looping continuously
 	| absalarm(str alarm)
	;
