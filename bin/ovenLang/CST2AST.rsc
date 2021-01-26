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
	 	case HeatingSetting sett: setts += absheating(unparse(sett.heating));
	 	case TemperatureSetting sett: setts += abstemperature(toInt(unparse(sett.temperature)));
		case TimeSetting sett: setts += abstime(toInt(unparse(sett.seconds)) + 60*toInt(unparse(sett.minutes)) + 60*60*toInt(unparse(sett.hours)) );
 		case LightSetting sett: setts += abslight(fromString(unparse(sett.light)));
 		case FanSetting sett: setts += absfan(fromString(unparse(sett.fan)));
 		case VolumeSetting sett: setts += absvolume(toInt(unparse(sett.volume)));
 		case PatternSetting sett: setts += abspattern(unparse(sett.pattern));
 		case LoopSetting sett: setts += absloop(toInt(unparse(sett.loop)));
 		case AlarmSetting sett: setts += absalarm(unparse(sett.alarm));
	}
	
	if(unparse(pre.presettype) == "alarm"){
		return abspresetalarm(unparse(pre.id), setts);
	} else {
		return abspresetmode(unparse(pre.id), setts);
	}
}
