module ccl::CST2AST

import ccl::AST;
import ccl::Syntax;
import String;
import ParseTree;

/*
 * -Implement a mapping from concrete syntax trees (CSTs) to abstract syntax trees (ASTs)
 * - Hint: Use switch to do case distinction with concrete patterns 
 * - Map regular CST arguments (e.g., *, +, ?) to lists 
 * - Map lexical nodes to Rascal primitive types (bool, int, str)
 */


public AbsProgram cst2ast(Program pr){
	list[AbsResource] res = [];
	
	visit(pr.resources){
		case Resource re: res += initResource(re);
	}
	return absprogram(res);
}

AbsResource initResource(Resource re){

	list[AbsMI] mis = [];
	
	visit(re.mis){
		case StorageMI mi: mis += initStoMI(mi);
		case ComputeMI mi: mis += initComMI(mi);
		case IdMI mi: mis += absidmi("id", unparse(mi));
		
	}
	return absresource(unparse(re.id), mis);
}

AbsMI initStoMI(StorageMI mi){
	list[AbsSpecification] specs = [];
	
	visit(mi.specs){
		case RegionSpec spec: specs += absregion("region", unparse(spec.region));
		case EngineSpec spec: specs += absengine("engine", unparse(spec.engine));
		case CPUSpec spec: specs += abscpu("cpu", toInt(unparse(spec.cores)));
		case OSSpec spec: specs += absos("os", unparse(spec.os));
		case MemorySpec spec: specs += absmemory("memory", toInt(unparse(spec.gb)));
		case StorageSpec spec: specs += absstorage("storage", unparse(spec.sto), toInt(unparse(spec.gb)));
		case IPV6Spec spec: specs += absipv6("ipv6", unparse(spec.ipv6) != "no");
	}
	
	return absmi("storage", unparse(mi.id), specs);
}

AbsMI initComMI(ComputeMI mi){
	list[AbsSpecification] specs = [];
	
	visit(mi.specs){
		case RegionSpec spec: specs += absregion("region", unparse(spec.region));
		case EngineSpec spec: specs += absengine("engine", unparse(spec.engine));
		case CPUSpec spec: specs += abscpu("cpu", toInt(unparse(spec.cores)));
		case OSSpec spec: specs += absos("os", unparse(spec.os));
		case MemorySpec spec: specs += absmemory("memory", toInt(unparse(spec.gb)));
		case StorageSpec spec: specs += absstorage("storage", unparse(spec.sto), toInt(unparse(spec.gb)));
		case IPV6Spec spec: specs += absipv6("ipv6", unparse(spec.ipv6) != "no");
	}
	
	return absmi("computing", unparse(mi.id), specs);
}
