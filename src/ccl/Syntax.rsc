module ccl::Syntax

/*
 * Define concrete syntax for CCL. The language's specification is available in the PDF (Section 3)
 */
 
lexical Id = [a-zA-Z0-9_]+;
lexical Value = [0-9]+ ;
extend lang::std::Layout;

keyword Reserved = Region | Engine | OS | Storage | IPV6 | Spec | Res | Mii;
keyword Region = "California" | "CapeTown" | "Frankfurt" | "Bogota" | "Seoul";
keyword Engine = "MySQL" | "PostgreSQL" | "MarinaDB" | "Oracle" | "SQLServer";
keyword OS = "Linux" | "Redhat" | "Ubuntu" | "Windows";
keyword Storage = "BLS" | "SSD";
keyword IPV6 = "yes" | "no";
keyword Spec = "region" | "engine" | "OS" | "CUP" | "memory" | "storage" | "IPV6";
keyword Res = "resource";
keyword Mii = "storage" | "computing";


start syntax Program 
	= "resource" Resource
	;

syntax Resource 
	=  Id "{" MI ("," MI)* "}"
	;

syntax MI
	= Mii Id id "{" Specification ("," Specification)* specs "}"
	| Id id
	;	
	
syntax Specification
	= Region : "region" ":" Region region
	| Engine : "engine" ":" Engine engine
	| OS : "OS" ":" OS os
	| CPU : "CPU" ":" Value cores "cores"
	| Memory : "memory" ":" Value gb_mem "GB"
	| Storage : "storage" ":" Storage "of" Value gb_sto "GB"
	| IPV6 : "IPV6" ":" IPV6 ipv6 
	;	

