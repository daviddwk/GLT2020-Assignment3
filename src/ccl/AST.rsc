module ccl::AST

/*
 * Define Abstract Syntax for CCL
 *
 * - make sure there is an almost one-to-one correspondence with the grammar (Syntax.rsc)
 */
 
 data AbsProgram = absprogram(list[AbsResource] resources);
 data AbsResource = absresource(str id, list[AbsMI] mis);
 data AbsMI =  absmi(str mitype, str id, list[AbsSpecification] specs)
 	| absidmi(str mitype, str id)
 	;
 data AbsSpecification = absregion(str spectype, str region)
 	| absengine(str spectype, str engine)
 	| absos(str spectype, str os)
	| abscpu(str spectype,int cores)
	| absmemory(str spectype, int gbs)
	| absstorage(str spectype, str storage, int gbs)
	| absipv6(str spectype, bool ipv6)
	;
