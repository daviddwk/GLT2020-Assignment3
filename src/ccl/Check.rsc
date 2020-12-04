module ccl::Check

import ccl::AST;
import List;
import IO;
import Set;

/*
 * -Implement a well-formedness checker for the CCL language. For this you must use the AST. 
 * - Hint: Map regular CST arguments (e.g., *, +, ?) to lists 
 * - Hint: Map lexical nodes to Rascal primitive types (bool, int, str)
 * - Hint: Use switch to do case distinction with concrete patterns
 */

 /*
 * Create a function called checkCloudConfiguration(...), which is responsible for calling all the required functions that check the program's well-formedness as described in the PDF (Section 3.2.) 
 * This function takes as a parameter the program's AST and returns true if the program is well-formed or false otherwise.
 */
 
/*
* Define a function per each verification defined in the PDF (Section 3.2.)
*/

public bool checkCloudConfiguration(AbsProgram program){

	if (!(checkLabel(program) && checkRefrence(program) && checkSpecs(program) && checkStorageSpecs(program) && checkComputingSpecs(program) && checkIfSameConfig(program))) return false;
	return true;
}

/*creadting lists of ids*/
bool checkLabel(AbsProgram program){
	list[str] resids = [];
	list[str] miids = [];
	for(int h <- [0 .. size(program.resources)]){
		resids += program.resources[h].id;
		for(int i <- [0 .. size(program.resources[h].mis)]){
			if (program.resources[h].mis[i].mitype != "id") miids += program.resources[h].mis[i].id;
		}
	}
/*making sure there are no duplicates*/
	set[str] setresids = toSet(resids);
	if(size(setresids) != size(resids)) return false;
	set[str] setmiids = toSet(miids);
	if(size(setmiids) != size(miids)) return false;
	return true;
}

bool checkRefrence(AbsProgram program){
	/* generate a list of ids of id type mis*/
	list[str] ids = [];
	for(int h <- [0 .. size(program.resources)]){
		/* no reusing ids between resources, but move this line back if you want that*/		
		for(int i <- [0 .. size(program.resources[h].mis)]){
			if(program.resources[h].mis[i].mitype == "id"){
				ids += program.resources[h].mis[i].id;
			}
		}
		/* makes sure these ids correspond with a compute or storage mi*/
	}
	for(int i <- [0 .. size(ids)]){
		bool refFound = false;
		for(int h <- [0 .. size(program.resources)]){
			for(int j <- [0 .. size(program.resources[h].mis)]){
				if(program.resources[h].mis[j].mitype != "id"){
					if(ids[i] == program.resources[h].mis[j].id){
						refFound = true;
					}	
				}
			}
			if(!refFound) return false;
		}
	}
	return true;
}

bool checkSpecs(AbsProgram program){
	for(int h <- [0 .. size(program.resources)]){
		for(int i <- [0 .. size(program.resources[h].mis)]){
			if(program.resources[h].mis[i].mitype == "storage"){
			
				bool region = false;
				bool engine = false;
				bool cpu = false;
				bool memory = false;
				bool storage = false;
				bool ipv6 = false;
				
				for(int j <- [0 .. size(program.resources[h].mis[i].specs)]){
					if(program.resources[h].mis[i].specs[j].spectype == "region"){
						if (region) return false;
						if (!region) region = true;				
					} else if (program.resources[h].mis[i].specs[j].spectype == "engine"){
						if (engine) return false;
						if (!engine) engine = true;
					} else if (program.resources[h].mis[i].specs[j].spectype == "cpu"){
						if (cpu) return false;
						if (!cpu) cpu = true;
					} else if (program.resources[h].mis[i].specs[j].spectype == "os"){
						return false;
					} else if (program.resources[h].mis[i].specs[j].spectype == "memory"){
						if (memory) return false;
						if (!memory) memory = true;
					} else if (program.resources[h].mis[i].specs[j].spectype == "storage"){
						if (storage) return false;	
						if (!storage) storage = true;
					} else if (program.resources[h].mis[i].specs[j].spectype == "ipv6"){
						if (ipv6) return false;
						if (!ipv6) ipv6 = true;
					}
				}
				if(!(region && engine && cpu && memory && storage && ipv6)) return false;
				
			} else if (program.resources[h].mis[i].mitype == "computing"){
			
				bool region = false;
				bool cpu = false;
				bool os = false;
				bool memory = false;
				bool storage = false;
				bool ipv6 = false;
				
				for(int j <- [0 .. size(program.resources[h].mis[i].specs)]){
					if(program.resources[h].mis[i].specs[j].spectype == "region"){
						if (region) return false;
						if (!region) region = true;				
					} else if (program.resources[h].mis[i].specs[j].spectype == "engine"){
						return false;
					} else if (program.resources[h].mis[i].specs[j].spectype == "cpu"){
						if (cpu) return false;
						if (!cpu) cpu = true;
					} else if (program.resources[h].mis[i].specs[j].spectype == "os"){
						if (os) return false;
						if (!os) os = true;
					} else if (program.resources[h].mis[i].specs[j].spectype == "memory"){
						if (memory) return false;
						if (!memory) memory = true;
					} else if (program.resources[h].mis[i].specs[j].spectype == "storage"){
						if (storage) return false;	
						if (!storage) storage = true;
					} else if (program.resources[h].mis[i].specs[j].spectype == "ipv6"){
						if (ipv6) return false;
						if (!ipv6) ipv6 = true;
					}
				}
				if(!(region && os && cpu && memory && storage && ipv6)) return false;
			}
		}
	}
	return true;
	/* !os cpu mem storage ipv6 engine region */
}

bool checkStorageSpecs(AbsProgram program){
	for(int h <- [0 .. size(program.resources)]){
	    for(int i <- [0 .. size(program.resources[h].mis)]){
	        if(program.resources[h].mis[i].mitype == "storage"){
	            for(int j <- [0 .. size(program.resources[h].mis[i].specs)]){
	                if(program.resources[h].mis[i].specs[j].spectype == "region" && (program.resources[h].mis[i].specs[j].region notin ["California","CapeTown","Frankfurt","Bogota","Seoul"])){
	                    return false;
	                }
	                if(program.resources[h].mis[i].specs[j].spectype == "engine" && (program.resources[h].mis[i].specs[j].engine notin ["MySQL","PostgreSQL","MarinaDB","Oracle","SQLServer"])){
	                    return false;
	                }
	                if(program.resources[h].mis[i].specs[j].spectype == "memory" && (program.resources[h].mis[i].specs[j].gbs > 64 || program.resources[h].mis[i].specs[j].gbs <= 0)){
	                    return false;
	                }
	                if(program.resources[h].mis[i].specs[j].spectype == "cpu" && program.resources[h].mis[i].specs[j].cores <= 0){
	                    return false;
	                }
	                if(program.resources[h].mis[i].specs[j].spectype == "storage" && (program.resources[h].mis[i].specs[j].gbs <= 0 || program.resources[h].mis[i].specs[j].gbs > 1000)){
	                    return false;
	                }
	            }
	        }
	    }
	}   
    return true;
}

bool checkComputingSpecs(AbsProgram program){
	for(int h <- [0 .. size(program.resources)]){
	    for(int i <- [0 .. size(program.resources[h].mis)]){
	        if(program.resources[h].mis[i].mitype == "computing"){
	            for(int j <- [0 .. size(program.resources[h].mis[i].specs)]){
	                if(program.resources[h].mis[i].specs[j].spectype == "region" && (program.resources[h].mis[i].specs[j].region notin ["California","CapeTown","Frankfurt","Bogota","Seoul"])){
	                    return false;
	                }
	                if(program.resources[h].mis[i].specs[j].spectype == "memory" && (program.resources[h].mis[i].specs[j].gbs > 64 || program.resources[h].mis[i].specs[j].gbs <= 0)){
	                    return false;
	                }
	                if(program.resources[h].mis[i].specs[j].spectype == "cpu" && program.resources[h].mis[i].specs[j].cores <= 0){
	                    return false;
	                }
	                if(program.resources[h].mis[i].specs[j].spectype == "storage" && (program.resources[h].mis[i].specs[j].gbs < 25 || program.resources[h].mis[i].specs[j].gbs > 1000)){
	                    return false;
	                }
	            }
	        }
	    }
	}   
    return true;
}

bool checkIfSameConfig(AbsProgram program){
    for(int h <- [0 .. size(program.resources)]){
        for(int i <- [0 .. size(program.resources[h].mis)]){
            for(int j <- [0 .. size(program.resources[h].mis)]){
                if(i != j){
                    if((program.resources[h].mis[i].mitype != "id") && (program.resources[h].mis[j].mitype != "id")){
                        sort(program.resources[h].mis[i].specs);
                        sort(program.resources[h].mis[j].specs);
                        if(program.resources[h].mis[i].specs == program.resources[h].mis[j].specs){
                            return false;
                        }
                    }
                }
            }
           
        }
    }
    return true;
}