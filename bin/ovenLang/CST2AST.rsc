module ovenLang::CST2AST

import ovenLang::AST;
import ovenLang::Syntax;
import String;
import Boolean;
import ParseTree;

/*creating a list of abstract presets*/
public AbsProgram cst2ast(Program prog){
	list[AbsPreset] pres = [];
	
	visit(prog.presets){
		case Preset pre: pres += initPreset(pre);
	}
	return absprogram(pres);
}

/*creating a list of abstract settings and returning the proper preset type*/
AbsPreset initPreset(Preset pre){

	list[AbsSetting] setts = [];
	
	visit(pre.settings){
	 	case HeatSetting sett: setts += absheat("heat", toInt(unparse(sett.heat)));
		case TimerSetting sett: setts += abstimer("timer", toInt(unparse(sett.time))); // 0 represents user input
 		case LightSetting sett: setts += abslight("light", unparse(sett.light));
 		case FanSetting sett: setts += absfan("fan", fromString(unparse(sett.fan)));
 		case VolumeSetting sett: setts += absvolume("volume", toInt(unparse(sett.vol)));
 		case BuzzerSetting sett: setts += absbuzzer("buzzer", unparse(sett.buzz));
 		case AlarmSetting sett: setts += absalarm("alarm", unparse(sett.alarm));
	}
	
	if(unparse(pre.presettype) == "alarm"){
		return abspresetalarm(unparse(pre.id), setts);
	} else {
		return abspresetmode(unparse(pre.id), setts);
	}
}