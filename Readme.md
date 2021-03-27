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

* MLton

    Tested 20130715


## SML/NJ

### Build smldoc

To build the documentation generator, you have to build a heap image with `ml-build` like below:
This must be done in 32bit mode, even if you use 64bit architecture host.

```sh
$ ml-build -32 src/main/sources.cm Main.main bin/smldoc
.
.
[creating directory .cm/x86-unix]
[code: 325, data: 69, env: 39 bytes]
```

This command build a heap image named `smldoc.x86-linux`.
The next step is convert the image to an executable.

```sh
$ export SMLNJ_HOME=/path/to/smlnj
$ bin/heap2exec-fix -32 bin/smldoc.x86-linux bin/smldoc
```


### Test

Performs unit tests by loading `src/test/sources.cm`.

```
- CM.make "src/test/sources.cm";
[autoloading]
.
.
[New bindings added.]
val it = true : bool
- TestMain.test();
............................
tests = 28, failures = 0, errors = 0
Failures:
Errors:
val it = () : unit
```


### Example

An documentation example project is contained in `./example/SMLBasis`.
This project provides Basis library documents of an old version of SML/NJ.

This command:

```
$ cd example/SMLBasis/src
example/SMLBasis/src $ ../../../bin/smldoc -a SMLDocOptions.txt
```

generates html documents to `example/SMLBasis/doc/api`.


## MLton

### Build smldoc

To build project, run the target `smldoc` of `Makefile.mlton`.
This project depends on [SMLFormat], so mlb mapping file which contains the path to it as `SMLFORMAT_LIB` is required.
The mlb mapping file is to be specified as `MLB_PATH_MAP`.

```
$ cat MLB_PATH_MAP
SMLFORMAT_LIB <path/to/smlformat>
$ make -f Makefile.mlton MLB_PATH_MAP=<path/to/mlb-path-map> smldoc
```


### Test

To run unit tests, run the `test` target.
This target requires [SMLUnit].

```
$ make -f Makefile.mlton MLB_PATH_MAP=<path/to/mlb-path-map> test
```


### Example

To generate documentations, run the `example` target.

```
$ make -f Makefile.mlton example
```

This target generates documentations of the Basis library into `./example/SMLBasis/doc/api`.


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


[SMLDoc]: https://www.pllab.riec.tohoku.ac.jp/smlsharp//?SMLDoc "SMLDoc"

