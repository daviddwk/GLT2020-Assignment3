module ccl::AST

/*
 * Define Abstract Syntax for CCL
 *
 * - make sure there is an almost one-to-one correspondence with the grammar (Syntax.rsc)
 */
 
 data AbsProgram = absprogram(AbsResource re);
 data AbsResource = absresource(str id, list[AbsMI] mis);
 data AbsMI =  absstomi(str mitype, str id, list[AbsSpecification] specs)
 	| abscommi(str mitype, str id, list[AbsSpecification] specs)
 	| absidmi(str mitype, str id)
 	;
 data AbsSpecification = absregion(str region)
 	| absengine(str engine)
 	| absos(str os)
	| abscpu(int cores)
	| absmemory(int gbs)
	| absstorage(str storage, int gbs)
	| absipv6(bool ipv6)
	;
