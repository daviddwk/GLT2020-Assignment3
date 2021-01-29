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
	 	case HeatingSetting sett: setts += absheating("heating", unparse(sett.heating));
	 	case TemperatureSetting sett: setts += abstemperature("temperature", toInt(unparse(sett.temperature)));
		case TimeSetting sett: setts += abstime("time", toInt(unparse(sett.seconds)) + 60*toInt(unparse(sett.minutes)) + 60*60*toInt(unparse(sett.hours)) );
 		case LightSetting sett: setts += abslight("light", fromString(unparse(sett.light)));
 		case FanSetting sett: setts += absfan("fan", fromString(unparse(sett.fan)));
 		case VolumeSetting sett: setts += absvolume("volume", toInt(unparse(sett.volume)));
 		case PatternSetting sett: setts += abspattern("pattern", unparse(sett.pattern));
 		case LoopSetting sett: setts += absloop("loop", toInt(unparse(sett.loop)));
 		case AlarmSetting sett: setts += absalarm("alarm", unparse(sett.alarm));
	}
	
	if(unparse(pre.presettype) == "alarm"){
		return abspresetalarm("alarm", unparse(pre.id), setts);
	} else {
		return abspresetmode("mode", unparse(pre.id), setts);
	}
}