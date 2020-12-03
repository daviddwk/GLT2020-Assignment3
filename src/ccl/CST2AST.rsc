module ccl::CST2AST
import ccl::AST;
import ccl::Syntax;
import util::Math;

import String;
/*
 * -Implement a mapping from concrete syntax trees (CSTs) to abstract syntax trees (ASTs)
 * - Hint: Use switch to do case distinction with concrete patterns 
 * - Map regular CST arguments (e.g., *, +, ?) to lists 
 * - Map lexical nodes to Rascal primitive types (bool, int, str)
 */
 
public AbsProgram cst2ast((Program)`resource <Resource re>`) = absprogram(cst2ast(re));
public AbsResource cst2ast((Resource)`<Id id> { <MI* mis> }`) = absresource(toInt("<id>"), [cst2ast(mi) | mi <- mis]);
public AbsMI cst2ast((MI)`<Mii mii> <Id id> { <Specification* specs> }`) = absmi(toInt("<id>"), [cst2ast(spec) | spec <- specs]);
public AbsSpecification cst2ast((Specification)`region : <Region rg>`) = absregion("<rg>");
public AbsSpecification cst2ast((Specification)`engine : <Engine eg>`) = absengine("<eg>");
public AbsSpecification cst2ast((Specification)`OS : <OS os>`) = absos("<os>");
public AbsSpecification cst2ast((Specification)`CPU : <Value va>`) = abscpu(toInt("<va>"));
public AbsSpecification cst2ast((Specification)`memory : <Value va> GB`) = absmemory(toInt("<va>"));
public AbsSpecification cst2ast((Specification)`storage : <Storage st> of <Value gb> GB`) = absstorage("<st>", toInt("<gb>"));
public AbsSpecification cst2ast((Specification)`IPV6 : <IPV6 ip>`) = absipv6("<ip>");
