module ccl::Syntax

/*
 * Define concrete syntax for CCL. The language's specification is available in the PDF (Section 3)
 */
 
lexical Id = ([a-zA-Z0-9_] !<< [a-zA-Z][a-zA-Z0-9_]* !>> [a-zA-Z0-9_]);
lexical Value = ([1-9][0-9]*) | [0] ;

layout Whitespace = [\t-\n\r\ ]*; 

keyword Reserved = Region | Engine | OS | Storage | IPV6 | Spec | Res;
keyword Region = "California" | "CapeTown" | "Frankfurt" | "Bogota" | "Seoul";
keyword Engine = "MySQL" | "PostgreSQL" | "MarinaDB" | "Oracle" | "SQLServer";
keyword OS = "Linux" | "Redhat" | "Ubuntu" | "Windows";
keyword Storage = "BLS" | "SSD";
keyword IPV6 = "yes" | "no";
keyword Spec = "region" | "engine" | "OS" | "CPU" | "memory" | "storage" | "IPV6";
keyword Res = "resource";


start syntax Program 
	= "resource" Resource resource
	;

syntax Resource 
	=  Id id "{" MIs mis "}"
	;

syntax MIs
	= MI mi
	| MI mi "," MIs mis 
	;

syntax MI
	= StorageMI storage
	| ComputeMI compute
	| IdMI id
	;

syntax StorageMI
	= "storage" Id id "{" Specifications specs "}"
	;
	
syntax ComputeMI
	= "computing" Id id "{" Specifications specs "}"
	;
	
syntax IdMI
	= Id id
	;

syntax Specifications
	= Specification
	| Specification "," Specifications
	;

syntax Specification
	=  RegionSpec 
	| EngineSpec
	| CPUSpec
	| OSSpec
	| MemorySpec
	| StorageSpec
	| IPV6Spec
	;

syntax RegionSpec
	= "region" ":" Region region
	;
	
syntax EngineSpec
	= "engine" ":" Engine engine
	;
	
syntax OSSpec
	= "OS" ":" OS os
	;
	
syntax CPUSpec
	= "CPU" ":" Value cores "cores"
	;
	
syntax MemorySpec
	= "memory" ":" Value gb "GB"
	;
	
syntax StorageSpec
	= "storage" ":" Storage sto "of" Value gb "GB"
	;
	
syntax IPV6Spec
	= "IPV6" ":" IPV6 ipv6 
	;
