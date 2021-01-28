module ccl::Check

import ccl::AST;
import String;
import util::Math;
import List;
import Set;
import IO;

public bool checkCloudConfiguration(AbsProgram program){
	//Runs every individial check function and returns true if there are no issues
	if (!(checkLabel(program) && checkSettings(program) && checkModeSetting(program) && checkAlarmSetting(program) && checkIfSameConfig(program))) return false;
	return true;
}

//checks to make sure there are no duplicate IDs
bool checkLabel(AbsProgram program){
	list[str] presetids = [];
	for(int h <- [0 .. size(program.presets)]){
		presetids += program.presets[h].id;
	}
	set[str] setpresetids = toSet(presetids);
	if(size(setpresetids) != size(presetids)) return false;
	return true;
}

//checks that every MI has the correct specifications and no extras
bool checkSettings(AbsProgram program){
	for(int h <- [0 .. size(program.presets)]){
		if(program.presets[h].presettype == "mode"){
		
			bool alarm = false;
			bool fan = false;
			bool heating = false;
			bool light = false;
			bool temperature = false;
			bool time = false;
			
			for(int i <- [0 .. size(program.presets[h].settings)]){
				if(program.presets[h].settings[i].settype == "alarm"){
					if (alarm) return false;
					if (!alarm) alarm = true;				
				} else if (program.presets[h].settings[i].settype == "fan"){
					if (fan) return false;
					if (!fan) fan = true;
				} else if (program.presets[h].settings[i].settype == "heating"){
					if (heating) return false;
					if (!heating) heating = true;
				} else if (program.presets[h].settings[i].settype == "light"){
					if (light) return false;
					if (!light) light = true;
				} else if (program.presets[h].settings[i].settype == "temperature"){
					if (temperature) return false;	
					if (!temperature) temperature = true;
				} else if (program.presets[h].settings[i].settype == "time"){
					if (time) return false;
					if (!time) time = true;
				}
			}
			if(!(alarm && fan && heating && light && temperature && time)) return false;
			
		} else if (program.presets[h].presettype == "alarm"){
		
			bool fan = false;
			bool light = false;
			bool loop = false;
			bool pattern = false;
			bool volume = false;
			
			for(int i <- [0 .. size(program.presets[h].settings)]){
				if(program.presets[h].settings[i].settype == "fan"){
					if (fan) return false;
					if (!fan) fan = true;
				} else if (program.presets[h].settings[i].settype == "light"){
					if (light) return false;
					if (!light) light = true;
				} else if (program.presets[h].settings[i].settype == "loop"){
					if (loop) return false;
					if (!loop) loop = true;
				} else if (program.presets[h].settings[i].settype == "pattern"){
					if (pattern) return false;
					if (!pattern) pattern = true;
				} else if (program.presets[h].settings[i].settype == "volume"){
					if (volume) return false;	
					if (!volume) volume = true;
				}
			}
			if(!(fan && loop && light && pattern && volume)) return false;
		}
	}
	return true;
}

//checks that storage mi specs are set appropriately
bool checkModeSetting(AbsProgram program){
	for(int h <- [0 .. size(program.presets)]){
        if(program.presets[h].presettype == "mode"){
            for(int i <- [0 .. size(program.presets[h].settings)]){
                if(program.presets[h].settings[i].settype == "alarm" && !checkCustomAlarm(program, program.presets[h].settings[i].alarm)){
                    return false; //search in presets the name of alarm
                }
                if(program.presets[h].settings[i].settype == "heating" && (program.presets[h].settings[i].heat notin ["top","bottom","both"])){
                    return false;
                }
                if(program.presets[h].settings[i].settype == "temperature" && (program.presets[h].settings[i].temperature > 290 || program.presets[h].settings[i].temperature < 0)){
                    return false;
                }
                /*if(program.presets[h].settings[i].settype == "time" && program.presets[h].settings[i].time < 0){
                    return false;
                }*/
            }
        }
	}   
    return true;
}

//checks that computing mi specs are set appropriately
bool checkAlarmSetting(AbsProgram program){
	for(int h <- [0 .. size(program.presets)]){
	        if(program.presets[h].presettype == "alarm"){
	            for(int j <- [0 .. size(program.presets[h].settings)]){
	                if(program.presets[h].settings[j].settype == "loop" && program.presets[h].settings[j].loop < 0){
	                	print("loop");
	                    return false; //max?
	                }
	                if(program.presets[h].settings[j].settype == "pattern" && size(program.presets[h].settings[j].pattern) <= 0 ){
	                    return false;
	                }
	                if(program.presets[h].settings[j].settype == "volume" && (program.presets[h].settings[j].volume < 1 || program.presets[h].settings[j].volume > 10)){
	                    return false;
	                }
	            }
	        }
	}   
    return true;
}

//checks that no mis have the exact same configuration of specifications
bool checkIfSameConfig(AbsProgram program){
    for(int i <- [0 .. size(program.presets)]){
        for(int j <- [0 .. size(program.presets)]){
                if(i != j){
                    if((program.presets[i].presettype != "id") && (program.presets[j].presettype != "id")){
                        sort(program.presets[i].settings);
                        sort(program.presets[j].settings);
                        if(program.presets[i].settings == program.presets[j].settings){
                            return false;
                        }
                    }
                }
           
        }
    }
    return true;
}

bool checkCustomAlarm(AbsProgram program, str alarm){
	for(int i <- [0 .. size(program.presets)]){
		if(program.presets[i].presettype == "alarm" && program.presets[i].id == alarm){
			return true;
		}
	}
	return false;
}