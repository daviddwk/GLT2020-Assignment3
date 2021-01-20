module ovenLang::AST

 data AbsProgram = absprogram(list[AbsPreset] presets);
 data AbsPreset = abspresetalarm(str id, list[AbsSetting] settings)
 	| abspresetmode(str id, list[AbsSetting] settings)
 	; 
 data AbsSetting= abstimer(str settype, int time) // 0 represents user input
 	| abslight(str settype, str light)
 	| absheat(str settype, int heat)
 	| absfan(str settype, bool fan)
 	| absvolume(str settype, int vol)
 	| absbuzzer(str settype, str buzz)
 	| absalarm(str settype, str alarm)
	;
