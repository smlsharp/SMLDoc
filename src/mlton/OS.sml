(**
 * @author YAMATODANI Kiyoshi
 * @copyright 2010, Tohoku University.
 *)
structure OS =
struct
  open OS
  structure FileSys = 
  struct
    open FileSys
    val readDir =
        fn stream => case readDir stream of NONE => "" | SOME name => name
                                                                                end
end

        