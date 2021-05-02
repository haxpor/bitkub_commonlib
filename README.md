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
* `static-release` (default)

You just execute the following command

* `make` - this will build with target `static-release`, optimized for your production use
* `make static-debug` - no optimization level applied when compile, suitable for debugging purpose

It will build the result static library into `bin/` directory, along with copying public header files into `bin/include/` directory.

> For now, this project is small and recommended to build as statically shared library. In the future, we might add support for dynamically shared library.

## Clean

Use `make clean` to clean all intermediate built files.

# Notice

**This tool suite is created independently without warranty. As well as please be advised and do your due diligent before investing, it has risk involved. Author and contributors altogether are not responsible to any results done from using the tools.**

# License

GPLv2, see [LICENSE](https://github.com/haxpor/bitkub_commonlib/blob/main/LICENSE).
Wasin Thonkaew
