module ccl::Syntax

/*
 * Define concrete syntax for CCL. The language's specification is available in the PDF (Section 3)
 */
 
lexical Id = ([a-zA-Z0-9_] !<< [a-zA-Z][a-zA-Z0-9_]* !>> [a-zA-Z0-9_]);
lexical Value = [1-9][0-9]* ;
extend lang::std::Layout;

keyword Region = "California" | "CapeTown" | "Frankfurt" | "Bogota" | "Seoul";
keyword Engine = "MySQL" | "PostgreSQL" | "MarinaDB" | "Oracle" | "SQLServer";
keyword OS = "Linux" | "Redhat" | "Ubuntu" | "Windows";
keyword Storage = "BLS" | "SSD";



start syntax Program 
	= Resources program
	;

syntax Resource 
	= resource : "resource" Id id "{" MIs "}"
	;
syntax Resources
	= Resource
	| Resource "," Resources
	;

syntax MI
	= mi_store : "storage" Id id "{" Specs specs "}"
	| mi_compute : "computing" Id id "{" Specs specs "}"
	| mi_id : Id id
	;	
syntax MIs
	= MI
	| MI "," MIs
	;
	
syntax Spec
	= Region : "region" ":" Region region
	| Engine : "engine" ":" Engine engine
	| OS : "OS" ":" OS os
	| CPU : "CPU" ":" Value cores "cores"
	| Memory : "memory" ":" [1-64] gb_mem "GB"
	| Storage : "storage" ":" Storage "of" Value gb_sto "GB"
	| IPV6 : "IPV6" ":" ("yes" | "no" ) ipv6 
	;	
syntax Specs
	= Spec
	| Spec "," Specs
	;
