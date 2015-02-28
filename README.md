# UberSignals

[![Build Status](https://travis-ci.org/SimonDanisch/UberSignals.jl.svg?branch=master)](https://travis-ci.org/SimonDanisch/UberSignals.jl)


Concept for a Signal system, loosely inspired by [Reactive.jl](https://github.com/JuliaLang/Reactive.jl)

### Wanted Features:
* Inline callback code
* Transfer entire branches to jitted OpenCL/OpenGL kernels
* Multithreadded branching
* Different event sources, like websockets, disc, files, OpenCL-events, IDE-code changes, etc...
* Different caching methods, for events that are emitted faster than they're being procest
* Bidirectional signals
* lazy updates (state changes only get updated when read)

### Problems which Hypersignals should make easier

* creating memory optimal code paths. For example concider loading a video from the hdd, load it into ram, then transfer it to the GPU to filter it. After the filtering, compress it and send it via a network connection to another client. This should look something like this in Hypersignals:
```Julia
video = lift(open, "file.mp4") # create a signal from a file
filtered = lift(video) do frame  
  filter!(kernel(:gauss, 4,4), frame)
  hue!(frame, 0.4)
end
compressed = lift(compress, filtered)
lift(compressed) do frame
  sent(socket, frame)
end
```
This lift should now sent a data stream to socked with this this kind of pseudo code:
```julia
video = read_video_from_hdd_into_ram(filepath)
gpu_code = find_gpu_segments(signal) # should recognize, that filter!, hue! 
#and compress is executable on the gpu and can use the same gpu memory.
gpu_kernel = compile(gpu_code)
while !done(video)
  frame = next(video)
  upload_to_gpu(frame)
  frame = execute(gpu_kernel, frame) # shouldn't allocate new memory and reuse both ram and video memory
  sent(socket, frame) # some magic function that serializes the signal and sents it optimally to another client.
end
```
* should make it easier to have asynchronous and heterogenous events processed on the GPU and CPU.
* 
