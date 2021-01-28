module ccl::AST

 data AbsProgram = absprogram(list[AbsPreset] presets);
 data AbsPreset = abspresetalarm(str presettype, str id, list[AbsSetting] settings)
 	| abspresetmode(str presettype, str id, list[AbsSetting] settings)
 	; 
 data AbsSetting = abstime(str settype, int time) // time in seconds
 	| abslight(str settype, bool light)
 	| absheating(str settype, str heat)
 	| abstemperature(str settype, int temperature)
 	| absfan(str settype, bool fan)
 	| absvolume(str settype, int volume)
 	| abspattern(str settype, str pattern)
 	| absloop(str settype, int loop) // 0 represents looping continuously
 	| absalarm(str settype, str alarm)
	;