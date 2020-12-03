module ccl::AST

/*
 * Define Abstract Syntax for CCL
 *
 * - make sure there is an almost one-to-one correspondence with the grammar (Syntax.rsc)
 */
 
 data AbsProgram = absprogram(AbsResource resource);
 data AbsResource = absresource(int id, list[AbsMI] mis);
 data AbsMI = absmi(int id, list[AbsSpecification] specs);
 data AbsSpecification = absregion(str region)
 	| absengine(str engine)
 	| absos(str os)
	| abscpu(int cores)
	| absmemory(int gbs)
	| absstorage(str storage, int gbs)
	| absipv6(str ipv6)
	;
