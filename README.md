# UberSignals

[![Build Status](https://travis-ci.org/SimonDanisch/UberSignals.jl.svg?branch=master)](https://travis-ci.org/SimonDanisch/UberSignals.jl)


Concept for a Signal system, loosely inspired by [Reactive.jl](https://github.com/JuliaLang/Reactive.jl)

Wanted Features:
* Inline callback code
* Transfer entire branches to jitted OpenCL/OpenGL kernels
* Multithreadded branching
* Different event sources, like websockets, disc, files, OpenCL-events, IDE-code changes, etc...
* Different caching methods, for events that are emitted faster than they're being procest
