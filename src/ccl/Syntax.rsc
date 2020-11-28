module ccl::Syntax

/*
 * Define concrete syntax for CCL. The language's specification is available in the PDF (Section 3)
 */
 
lexical Id = ([a-zA-Z][a-zA-Z0-9_]* !>> [a-zA-Z0-9_]) \ Reserved;
lexical Value = [1-9][0-9]* ;

layout LAYOUT = [\t-\n\r\ ]* !>> [\t-\n\r\ ] ;

keyword Reserved = "resource" | Types | Specifications | Regions | Engines | OSes | Bool | Storages;

keyword Bool = "yes" | "no";
keyword Types = "storage" | "computing";
keyword Specifications = "region" | "engine" | "CPU" | "memory" | "IPV6" | "storage";
keyword Regions = "california" | "cape_town" | "frankfurt" | "bogota" | "seoul";
keyword Engines = "mysql" | "postgresql" | "marinadb" | "oracle" | "sqlserver";
keyword OSes = "linux" | "redhat" | "ubuntu" | "windows";
keyword Storages = "bls" | "ssd";



start syntax Program 
	= program : (Resource ("," Resource)*) program
	;

syntax Resource 
	= resource : "resource" Id rs_id "{"
			(MI ("," MI)*) mis
		"}"
	;

syntax MI
	=	mi_store : "storage" Id mi_id "{"
			(Specification ("," Specification)*) specs
		"}"
	| 	mi_compute : "computing" Id mi_id "{"
			(Specification ("," Specification)*) specs
		"}"
	| 	mi_id : Id mi_id
	;
	
syntax Specification
	= Region : "region" ":" Regions region
	| Engine : "engine" ":" Engines engine
	| OS : "OS" ":" OSes os
	| CPU : "CPU" ":" Value core "cores"
	| Memory : "memory" ":" Value gb_mem "GB"
	| Storage : "storage" ":" Storages storage "of" Value gb_sto "GB"
	| IPV6 : "IPV6" ":" Bool ipv6 
	;
