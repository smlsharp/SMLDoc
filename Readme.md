# SMLDoc : Document Generator for Standard ML

This is **unofficial** repository for [SMLDoc] distribution.


## What is this

SMLDoc is a tool for generating API documentation in HTML format from doc comments in source code written in Standard ML.


## What is **not** this

* This is not official repository.

Initially, contents of this repository is salvaged from the official SMLDoc distribution (included in SML# 0.90 compiler distribution).


## Support platforms

* SML#

    Not supported.

* SML/NJ

    Tested 110.98


## SML/NJ

### Build smldoc

To build the documentation generator first build heap image by `ml-build` like below:
This must be done in 32bit mode, even if you use 64bit architecture host.

```sh
$ ml-build -32 smldoc.cm Main.main bin/smldoc
.
.
[creating directory .cm/x86-unix]
[code: 325, data: 69, env: 39 bytes]
```

This command build a heap image named `smldoc.x86-linux`.
Next it is needed to convert the image to an executable.

```sh
$ bin/heap2exec-fix -32 bin/smldoc.x86-linux bin/smldoc
```


## License

This software has been developed as a part of the SML# project.
It is distributed under the BSD-style SMLSharp license, which is
included in the file LICENSE in this directory.

For the details of SML# project, consult the web page at:
http://www.pllab.riec.tohoku.ac.jp/smlsharp/

## Author

@author
: YAMATODANI Kiyoshi

@copyright
: 2010, Tohoku University.


[SMLDoc]: https://www.pllab.riec.tohoku.ac.jp/smlsharp/ja/?cmd=view&p=SMLDoc&key=SMLDoc "SMLDoc"
