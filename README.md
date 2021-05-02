# commonlib

It is aimed to be linked statically (but also possible for shared library) with other tools as those will reuse code in this repository.

The general approach is to

* create `bitkub` directory
* clone all sub-tools into `bitkub` directory
* then respectively build each tool starting with `bitkub_commonlib` first before others

# Build

## Make a static shared library

The following are targets available for `Makefile`

* `static-debug`
* `static-release`
* `all` (default)

You just execute the following command

* `make` - this will build with both target `static-debug` and `static-release`, output into `bin/debug` and `bin/release` respectively
* `make static-debug` - no optimization level applied when compile, suitable for debugging purpose
* `make static-release` - build with optimization level 2, suitale for production use

> For now, this project is small and recommended to build as statically shared library. In the future, we might add support for dynamically shared library.

# Policy that sub-tools adhere to

Other sub-tools (mostly) will depend on this project, and its `Makefile` should build a single target either against debug, or release version of this project.
Thus it should specify the proper include directory, and link against the correct library file as output inside `bin/` directory.

## Clean

Use `make clean` to clean all intermediate built files.

# Notice

**This tool suite is created independently without warranty. As well as please be advised and do your due diligent before investing, it has risk involved. Author and contributors altogether are not responsible to any results done from using the tools.**

# License

GPLv2, see [LICENSE](https://github.com/haxpor/bitkub_commonlib/blob/main/LICENSE).
Wasin Thonkaew
