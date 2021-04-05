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


## Dependency

This project depends on:

- [SMLFormat]
- [SMLUnit] for unit test


## SML/NJ

### Build

To build the [SMLDoc], run the `smldoc` target.
This target requires [SMLFormat] which is referenced as `$/smlformatlib.cm`.

```sh
$ make -f Makefile.smlnj smldoc
```


### Install

To install `smldoc`, run the `install` target.

```sh
$ make -f Makefile.smlnj install [PREFIX=/path/to/install]
```


### Test

To run unit tests, run the `test` target.
This target requires [SMLUnit] which is referenced as `SMLUNIT_LIB`.

```sh
$ make -f Makefile.smlnj test
```


### Example

The `example` target generates documentation of SMLBasis library to `doc/SMLBasis`.
And the `smldoc-doc` target generates documentations of [SMLDoc] itself to `doc/smldoc` which depends on the `SMLBasis` documentation.

```
$ make -f Makefile.smlnj example
$ make -f Makefile.smlnj smldoc-doc
```


## MLton

### Build smldoc

To build [SMLDoc], run the target `smldoc` of `Makefile.mlton`.
This project depends on [SMLFormat] which is referenced as `SMLFORMAT_LIB`.

```
$ export MLB_PATH_MAP=/path/to/mlb-path-map
$ make -f Makefile.mlton smldoc
```

The target `smldoc` generates documentation of SMLDoc using [SMLDoc] itself.
If you do not need to generate documentation, run the `smldoc-nodoc` target.

```sh
$ make -f Makefile.smlnj smldoc-nodoc
```


### Test

To run unit tests, run the `test` target.
This target requires [SMLUnit] which is referenced as `SMLUNIT_LIB`.

```
$ export MLB_PATH_MAP=path/to/mlb-path-map
$ make -f Makefile.mlton test
```


### Example

To generate documentations of the Basis library, run the `example` target.
This target generates documentations to `doc/SMLBasis`.

```
$ make -f Makefile.mlton example
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


[SMLDoc]: https://www.pllab.riec.tohoku.ac.jp/smlsharp//?SMLDoc "SMLDoc"

[SMLFormat]: https://www.pllab.riec.tohoku.ac.jp/smlsharp//?SMLFormat "SMLFormat"

[SMLUnit]: https://github.com/smlsharp/SMLUnit "SMLUnit"

