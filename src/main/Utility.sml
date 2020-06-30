(**
 *  This module provides functions independent of the specific applications.
 *
 * @author YAMATODANI Kiyoshi
 * @copyright 2010, Tohoku University.
 * @version $Id: Utility.sml,v 1.5 2007/02/18 03:06:46 kiyoshiy Exp $
 *)
structure Utility =
struct

  (***************************************************************************)

  structure PC = ParserComb
  structure SS = Substring

  (***************************************************************************)

  (**
   *  interleave elements of a list with separators.
   * @params separator list
   * @param separator the separator
   * @param list the list
   * @return the list interleaved with separators
   *)
  fun interleave separator [] = []
    | interleave separator strings =
      (rev
       (foldl
        (fn (string, strings) => string :: separator :: strings)
        [hd strings]
        (tl strings)))

  (**
   *  Concat strings with separator.
   * <p>
   *  <code>String.concatWith</code> in the SMLBasis library provides
   * the same functionality, but this function is not implemented by some
   * version of SML/NJ.
   * </p>
   *
   * @params separator strings
   * @param separator the separator
   * @param string the list of string
   * @return the concatenation of the strings using the separator
   *)
  fun interleaveString separator strings =
      String.concat (interleave separator strings)

  (**
   * indicates whether a list is a prefix of another list.
   * @params (left, right)
   * @param left left list
   * @param right right list
   * @return true if the <code>left</code> is a prefix of the
   *     <code>right</code>.
   *)
  fun isPrefixOf ([], right) = true
    | isPrefixOf (_, []) = false
    | isPrefixOf (left::leftTail, right::rightTail) =
      left = right andalso isPrefixOf (leftTail, rightTail)

  (**
   * split a list into a pair of the elements but the last element and
   * the last element.
   * <p>
   * Example:
   * <pre>splitLast [1, 2, 3, 4]</pre>
   * returns
   * <pre>([1, 2, 3], 4)</pre>
   *
   * @params list
   * @param list a list
   * @return a pair of first n-1 elements and the last element if the
   *         <code>list</code> has n elements.
   *)
  fun splitLast list = (List.take (list, List.length list - 1), List.last list)

  (**
   * sorts a list.
   * <p>
   * ToDo : use efficient algorithm.
   * </p>
   * @params comparator list
   * @param comparator a function which compares two elements in the list.
   *       When applied to (left, right), it must return true if left < right.
   * @param list the list to be sorted.
   * @return the sorted list
   *)
  fun sort isBefore list =
    let
      fun insert (element, []) = [element]
        | insert (element, (head :: tail)) =
          if isBefore (element, head)
          then (element :: head :: tail)
          else head :: (insert (element, tail))
    in
      foldl insert [] list
    end

  (**
   * filter out repeated elements in a list.
   * @params list
   * @param list sorted list
   * @return a list in which adjacent equal elements are merged
   *)
  fun uniq [] = []
    | uniq (head :: tail) =
      let
        fun scan (element, results) =
            if element = hd results then results else element :: results
      in List.rev(foldl scan [head] tail)
      end

  (**
   * build a predicator which is a disjunction of predicators.
   * @params conditions value
   * @param conditions a list of predicator whose type is <code>'a -&gt; bool
   *        </code>
   * @param value the value to be examined.
   * @return true if any of conditions returns true when applied to the <code>
   *        value</code>.
   *)
  fun satisfyAny conditions value =
      let
        fun f [] = false
          | f (condition::conditions) =
            if condition value then true else f conditions
      in f conditions end

  (**
   * build a predicator which is a conjunction of predicators.
   * @params conditions value
   * @param conditions a list of predicator whose type is <code>'a -&gt; bool
   *        </code>
   * @param value the value to be examined.
   * @return true if all of conditions return true when applied to the <code>
   *        value</code>.
   *)
  fun satisfyAll conditions value =
      let
        fun f [] = true
          | f (condition::conditions) =
            if condition value then f conditions else false
      in f conditions end

  (**
   * case-insensitive version of <code>String.collate</code>
   * @params (left, right)
   * @param left left string
   * @param right right string
   * @return <code>order</code>
   *)
  fun compareStringNoCase (left, right) =
      String.collate
      (fn (left, right) => Char.compare(Char.toUpper left, Char.toUpper right))
      (left, right)

  (**
   *  raised by the <code>tokenizeString</code> if the string ends with
   * a unescaped backslash.
   *)
  exception MissingEscapedChar

  (**
   * break a string into tokens (with escape interpretation facility).
   * <p>
   * Example:
   * <pre>
 tokenizeString Char.isSpace " --header=Generated\\ by\\ SMLDoc\\ 1.0 foo.sml "
   * </pre>
   * returns
   * <pre>
["--header=Generated by SMLDoc 1.0","foo.sml"]
   * </pre>
   * A charcter following a backslash is treated as an ordinary char.
   * @params isDelimiter string
   * @param isDelimiter a function which receive a character and returns true
   *                    if it is a delimiter char.
   * @param string a string
   * @exception MissingEscapedChar if the string ends a backslash which is
   *                    not escaped by preceding another backslash.
   *)
  fun tokenizeString isDelimiter string =
      let
        fun inDelimiter [] tokens = tokens
          | inDelimiter (c::chars) tokens =
            if isDelimiter c
            then inDelimiter chars tokens
            else
              (* NOTE :
               * If we write here as follows,
               *   inToken chars [c] tokens
               * a token which begins with a '\' is not processed properly.
               * So, the 'c' is passed to 'inToken' and be checked again there.
               *)
              inToken (c::chars) [] tokens
        and inToken [] currentToken tokens = currentToken :: tokens
          | inToken [#"\\"] currentToken tokens = raise MissingEscapedChar
          | inToken (#"\\"::c::chars) currentToken tokens =
            inToken chars (c::currentToken) tokens
          | inToken (c::chars) currentToken tokens =
            if isDelimiter c
            then inDelimiter chars (currentToken::tokens)
            else inToken chars (c::currentToken) tokens
      in
        List.rev(map (implode o List.rev) (inDelimiter (explode string) []))
      end

  (**
   *  replaces string.
   * <p>
   *  example:
   * <pre>
   * - Utility.replaceString "foo" "bar" "fooboofooboofoo";
   * val it = (3,"barboobarboobar") : int * string
   * </pre>
   * </p>
   * @params oldString newString string
   * @param oldString the string to be replaced
   * @param newString the string to be inserted
   * @return a pair of <ul>
   *   <li>the number of replace performed</li>
   *   <li>the string in which occurrences of <code>oldString</code> are
   *     replaced with <code>newString</code></li>
   * </ul>
   *)
  fun replaceString oldString newString string =
    let
      val replacedCount = ref 0
      val oldStringSize = String.size oldString
      val newSubstring = SS.extract (newString, 0, NONE)

      fun replace (substring, substrings) =
          let val (prefix, suffix) = SS.position oldString substring
          in
            if SS.size suffix = 0
            then (prefix :: substrings)
            else
              (
                replacedCount := (!replacedCount) + 1;
                replace
                (
                  SS.triml oldStringSize suffix,
                  newSubstring :: prefix :: substrings
                )
              )
          end
      val resultString =
          SS.concat (rev (replace (SS.extract (string, 0, NONE), [])))
    in
      (!replacedCount, resultString)
    end

  fun replaceStringByTable table string =
      foldl
          (fn ((src, dest), replaced) =>
              #2(replaceString src dest replaced))
          string
          table
  (**
   * replaces strings in the contents of a file.
   * This function reads the contents of the source file and replaces the
   * occurrences of the first element of a pair in the
   * <code>keyValuePairs</code> with the second element of that pair.
   * The result of replace is output to the destination file.
   *
   * @params keyValuePairs (srcFileName, destFileName)
   * @param keyValuePairs a list of pairs of oldString and newString
   * @param srcFileName the name of source file
   * @param destFileName the name of destination file
   * @return unit
   *)
  fun replaceFile keyValuePairs (srcFileName, destFileName) =
      let val inStream = TextIO.openIn srcFileName
      in
        let val outStream = TextIO.openOut destFileName
        in
          let
            val newText = 
                foldl
                (fn ((key, newString), text) =>
                    let val (_, resultText) = replaceString key newString text
                    in resultText end)
                (TextIO.inputAll inStream)
                keyValuePairs
            val _ = TextIO.output (outStream, newText)
          in TextIO.closeOut outStream; TextIO.closeIn inStream end
            handle e => (TextIO.closeOut outStream; raise e)
        end
          handle e => (TextIO.closeIn inStream; raise e)
      end

  local
  fun isRBRACE #"}" = true
    | isRBRACE _ = false

  fun isDollar #"$" = true
    | isDollar _ = false

  fun scanText reader stream =
      PC.wrap
          (PC.oneOrMore(PC.eatChar (not o isDollar)), implode)
          reader stream
  fun scanVariable getVariable reader stream =
      PC.wrap
          (
            PC.seqWith
                #2
                (
                  PC.string "${",
                  PC.seqWith
                      #1
                      (PC.oneOrMore(PC.eatChar (not o isRBRACE)), PC.char #"}")
                ),
            getVariable o implode
          )
          reader stream
  fun scan getVariable reader stream =
      PC.wrap
          (
            PC.oneOrMore(PC.or' [scanVariable getVariable, scanText]),
            String.concat
          )
          reader stream

  in
  fun replaceEnv string =
      let
        fun getVariable env = Option.getOpt (OS.Process.getEnv env, "")
      in
        case StringCvt.scanString (scan getVariable) string of
          SOME s => s
        | NONE => string
      end
  end

  (***************************************************************************)

end