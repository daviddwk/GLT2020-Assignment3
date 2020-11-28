module ccl::AST

/*
 * Define Abstract Syntax for CCL
 *
 * - make sure there is an almost one-to-one correspondence with the grammar (Syntax.rsc)
 */
 
 public data PROGRAM = program(str rs_id, list[RESOURCE] resources);
 public data RESOURCE = resource(str rs_id, list[MI] mis);
 public data MI = mi_store(str mi_id, list[SPECIFICATION] specs)
 	| mi_compute(str mi_id, list[SPECIFICATION] specs)
 	| mi_id(str mi_id)
 	;
 public data SPECIFICATION = region(str region)
 	| engine(str engine)
 	| os(str os)
	| cpu(int core)
	| memory(int gb_mem)
	| storage(str storage, int gb_sto)
	| ipv6(bool ipv6)
	;