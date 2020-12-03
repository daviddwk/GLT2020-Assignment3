module ccl::AST

/*
 * Define Abstract Syntax for CCL
 *
 * - make sure there is an almost one-to-one correspondence with the grammar (Syntax.rsc)
 */
 
 data PROGRAM = program(list[RESOURCE] resources);
 data RESOURCE = resource(str exp, str id, list[MI] mis);
 data MI = mi_store(str exp, str id, list[SPECIFICATION] specs)
 	| mi_compute(str exp, str id, list[SPECIFICATION] specs)
 	| mi_id(str id)
 	;
 data SPECIFICATION = region(str exp, str region)
 	| engine(str exp, str engine)
 	| os(str exp, str os)
	| cpu(str exp, int cores, str exp2)
	| memory(str exp, int gbs, str exp2)
	| storage(str exp, str storage, str exp2, int gbs, str exp3)
	| ipv6(str exp, str ipv6)
	;
