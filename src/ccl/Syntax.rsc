module ccl::Syntax

/*
 * Define concrete syntax for CCL. The language's specification is available in the PDF (Section 3)
 */
 
layout Layout = [\t\n\ \r\f]*;

lexical Identifier = ([a-zA-Z0-9_] !<< [a-zA-Z][a-zA-Z0-9_]* !>> [a-zA-Z0-9_]) \ Reserved;
lexical Value = [1-9][0-9]* ;

keyword Reserved = "resource" | Types | Specifications | Regions | Engines | OSes | Bool | Storages;

keyword Bool = "yes" | "no";
keyword Types = "storage" | "computing";
keyword Specifications = "region" | "engine" | "CPU" | "memory" | "IPV6" | "storage";
keyword Regions = "california" | "cape_town" | "frankfurt" | "bogota" | "seoul";
keyword Engines = "mysql" | "postgresql" | "marinadb" | "oracle" | "sqlserver";
keyword OSes = "redhat" | "ubuntu" | "windows";
keyword Storages = "bls" | "ssd";

start syntax Program 
	= program: Cloud_Resource*
	;

syntax Cloud_Resource 
	= 	"resource" Identifier "{"
			MI ("," MI)*
		"}"
	;

syntax MI
	=	"storage" Identifier storage_part "{"
			Specification ("," Specification)*
		"}"
	| 	"computing" Identifier compute_id "{"
			Specification ("," Specification)*
		"}"
	| 	Identifier
	;
	
syntax Specification
	= "region" Regions
	| "engine" Engines
	| "OS" OSes
	| "CPU" Value "cores"
	| "memory" Value "GB"
	| "storage" Storages Value "GB"
	| "IPV6" Bool
	;
