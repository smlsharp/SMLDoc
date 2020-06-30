use "ml-yacc-lib.sml";
use "smlnj-lib.sml";
(* smlformatlib is loaded in prelude in SML#.
use "../../../SMLFormat/smlformatlib.sml";
*)

use "./Utility.sml";
use "./PATH_UTILITY.sig";
use "./PathUtility_MLton.sml";
use "./ParserUtil.sml";

use "./DocumentGenerationParameter.sml";

use "./AST.sig";
use "./Ast.sml";
use "./ASTUTIL.sig";
use "./AstUtil.sml";
use "./DocComment.sml";
use "./ML.grm.sig";
use "./ML.grm.sml";
use "./TokenTable.sml";
use "./ML.lex.sml";
use "./ParamPattern.grm.sig";
use "./ParamPattern.grm.sml";
use "./ParamPattern.lex.sml";
use "./AnnotatedAst.sml";

use "./EASY_HTML_PARSER.sig";
use "./EasyHTMLParser.sml";

use "./PARSER.sig";
use "./Parser.sml";

use "./DEPENDENCY_GRAPH.sig";
use "./DependencyGraph.sml";

use "./ElaboratedAst.sml";
use "./ENVSet.sml";
use "./ELABORATOR.sig";
use "./Elaborator.sml";

use "./DEPENDENCY_ANALYZER.sig";
use "./DependencyAnalyzer.sml";

use "./LinkFile.sml";
use "./LinkFile.grm.sig";
use "./LinkFile.grm.sml";
use "./LinkFile.lex.sml";
use "./EXTERNALREF_LINKER.sig";
use "./ExternalRefLinker.sml";

use "./Linkage.sml";
use "./Binds.sml";
use "./SUMMARIZER.sig";
use "./Summarizer.sml";

use "./DOCUMENT_GENERATOR.sig";
use "./HTML/html-lib.sml";
use "./HTMLDocumentGenerator.sml";

use "./SMLDOC.sig";
use "./SMLDoc.sml";

use "./GET_OPT.sig";
use "./GetOpt.sml";

use "./smlnjcm/CMSemantic.sml";
use "./smlnjcm/CM.grm.sig";
use "./smlnjcm/CM.grm.sml";
use "./smlnjcm/CM.lex.sml";
use "./smlnjcm/FileID.sml";
use "./smlnjcm/SourcePath.sml";
use "./smlnjcm/CMFILE_PARSER.sig";
use "./smlnjcm/CMFileParser.sml";

structure SMLofNJ =
struct
  (* ToDo : implement. *)
  fun exnHistory (exn : exn) =
      ["Sorry, exnHistory is not implemented."] : string list
end;

use "./Main.sml";

Main.main (CommandLine.name (), CommandLine.arguments ());
