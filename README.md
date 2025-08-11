# Zig Benchmark Library

A simple benchmark library.

Using (zig):
1. Import
2. `anne_benchmark.benchmark("my benchmark", someFunction);`
3. Profit!


Using (C):
1. Include `anne_benchmark.h`
2. Link against `anne_benchmark.a`
3. `benchmark_c("my benchmark", some_function);`


### Benchmarked function

##### Zig
```zig
pub fn someFunction(ctx: *anne_benchmark.Context) void {
    while (ctx.run()) {
        // do stuff...
    }
}
```

##### C
```c
void some_function(ctx: *void) {
    while (benchmark_run(ctx)) {
        // do stuff...
    }
}
```

### Advanced usage
See `src/root.zig`'s `Context.runExplicitTiming()` documentation.
