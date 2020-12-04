module ccl::Check

import ccl::AST;
import List;
import IO;

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

	if (!(checkLabel(program) && checkRefrence(program) && checkStorageSpecs(program) && checkComputingSpecs(program))) return false;
	return true;
}

bool checkLabel(AbsProgram program){
	/* every mi not of type id should have a unique id*/
	for(int i <- [0 .. size(program.re.mis)]){
		for(int j <- [0 .. size(program.re.mis)]){
			if(i != j){
				if((program.re.mis[i].mitype != "id") && (program.re.mis[j].mitype != "id")){
					if(program.re.mis[i].id == program.re.mis[j].id){
						return false;
					}
				}
			}
		}
	}
	return true;
}

bool checkRefrence(AbsProgram program){
	/* generate a list of ids of id type mis*/
	list[str] ids = [];
	
	for(int i <- [0 .. size(program.re.mis)]){
		if(program.re.mis[i].mitype == "id"){
			ids += program.re.mis[i].id;
		}
	}
	/* makes sure these ids correspond with a compute or storage mi*/
	for(int i <- [0 .. size(ids)]){
		bool refFound = false;
		for(int j <- [0 .. size(program.re.mis)]){
			if(program.re.mis[j].mitype != "id"){
				if(ids[i] == program.re.mis[j].id){
					refFound = true;
				}	
			}
		}
		if(!refFound) return false;
	}
	return true;
}

bool checkStorageSpecs(AbsProgram program){
	
	for(int i <- [0 .. size(program.re.mis)]){
		if(program.re.mis[i].mitype == "storage"){
		
			bool region = false;
			bool engine = false;
			bool cpu = false;
			bool memory = false;
			bool storage = false;
			bool ipv6 = false;
			
			for(int j <- [0 .. size(program.re.mis[i].specs)]){
				if(program.re.mis[i].specs[j].spectype == "region"){
					if (region) return false;
					if (!region) region = true;				
				} else if (program.re.mis[i].specs[j].spectype == "engine"){
					if (engine) return false;
					if (!engine) engine = true;
				} else if (program.re.mis[i].specs[j].spectype == "cpu"){
					if (cpu) return false;
					if (!cpu) cpu = true;
				} else if (program.re.mis[i].specs[j].spectype == "os"){
					return false;
				} else if (program.re.mis[i].specs[j].spectype == "memory"){
					if (memory) return false;
					if (!memory) memory = true;
				} else if (program.re.mis[i].specs[j].spectype == "storage"){
					if (storage) return false;	
					if (!storage) storage = true;
				} else if (program.re.mis[i].specs[j].spectype == "ipv6"){
					if (ipv6) return false;
					if (!ipv6) ipv6 = true;
				}
			}
			if(!(region && engine && cpu && memory && storage && ipv6)) return false;
		}
	}
		
	return true;
	/* !os cpu mem storage ipv6 engine region */
}

bool checkComputingSpecs(AbsProgram program){
	return true;
	/* os cpu + mem + storage 25-1000 ipv6 !engine region */
}

