# planarity-nim-sdl2

[Planarity](https://en.wikipedia.org/wiki/Planarity) is a graph geometry game, [originally implemented in Flash](http://planarity.net/) by John Tantalo, based on a concept by Mary Radcliffe. This version is implemented in [Nim](https://nim-lang.org/) using [SDL2](https://www.libsdl.org/) and [nim SDL2 bindings](https://github.com/nim-lang/sdl2).

There is an [elegant implementation](https://www.jasondavies.com/planarity/) in JavaScript by Jason Davies, as well as a GTK+ [desktop version](http://web.mit.edu/xiphmont/Public/gPlanarity.html) by Chris Montgomery of Xiph.org.


## Development Setup

I'm using [MSYS2](https://www.msys2.org/) with [MinGW](http://mingw-w64.org/) as a bash shell environment to build both nim and C code in Windows via the [gcc](https://gcc.gnu.org/) compiler. [Compiling to JS](https://nim-lang.org/docs/backends.html#backends-the-javascript-target) or compiling C via [clang](https://clang.llvm.org/) are also options, although the integration to SDL2 will be different.

Pacman is the MSYS2 package manager. The following packages are required:

* `pacman -S git`
* `pacman -S make`
* `pacman -S mingw-w64-x86_64-gcc`
* `pacman -S mingw-w64-x86_64-nim`
* `pacman -S mingw-w64-x86_64-nimble`
* `pacman -S mingw-w64-x86_64-SDL2`
* `pacman -S mingw-w64-x86_64-SDL2_ttf`

The nim binary is installed into `/mingw64/bin` which is not on the default `$PATH`. One way to fix this is to add the following to `~/.bashrc`

* `PATH="$PATH:/mingw64/bin"`

Nimble is the nim package manager. You can install project dependencies with the following command:

* `nimble install`

I had trouble with SSL integration and saw `Could not download: No SSL/TLS CA certificates found.` errors such as the following:

```
$ nimble refresh --verbose
Downloading Official package list
     Trying https://github.com/nim-lang/packages/raw/master/packages.json
   Warning: Could not download: No SSL/TLS CA certificates found.
     Trying https://irclogs.nim-lang.org/packages.json
     Trying https://nim-lang.org/nimble/packages.json
     Error: Refresh failed
        ... Could not download: No SSL/TLS CA certificates found.
```

To address this I used a solution [found on the web](https://forum.nim-lang.org/t/7551)

* `cd /mingw64/bin`
* `wget https://curl.se/ca/cacert.pem`

Having the `cacert.pem` file in my path allows me to use `nimble`.

I also found that `testament` was not installed as part of the pacman package, so I wrote my tests without it.


## Building

You can compile and launch the app with a simple nimble command:

* `nimble run`

Alternatively, use make:

* `make`

Inspect `Makefile` for more details.


## References

Some helpful Nim docs,

* [Nim Manual](https://nim-lang.org/docs/manual.html)
* [Nim by Example](https://nim-by-example.github.io/)
* [Nim Basics](https://narimiran.github.io/nim-basics/)

I'm working on other Planarity implementations. This helps me to learn various programming environments and have some personal projects to refer back to when I need a refresher.

* [planarity-py](https://github.com/parappayo/planarity-py)
* [planarity-winforms-cs](https://github.com/parappayo/planarity-winforms-cs)
* [planarity-qt](https://github.com/parappayo/planarity-qt)


## Nim Notes

* `*` after an identifier exports it
* `$` is the stringify operator, overloading it is similar to `__str__` in Python
