(**
 * @author YAMATODANI Kiyoshi
 * @copyright 2010, Tohoku University.
 *)
structure TestMain =
struct

  fun test () =
      let val tests = SMLDocTest.suite ()
      in SMLUnit.TextUITestRunner.runTest {output = TextIO.stdOut} tests
      end

  fun main (name, args) =
    (test (); OS.Process.exit OS.Process.success)

end