const root = @import("root.zig");
const std = @import("std");

const BenchFnC = fn (*anyopaque) callconv(.c) void;

/// Benchmarks a C function.
/// C functions must take in a `*void` ptr and pass that to the various `Context` functions.
export fn benchmark_c(name: [*c]const u8, f: *const BenchFnC) void {
    var ctx = root.Context.init();
    @call(.auto, f, .{&ctx});
    const name_slice: []const u8 = name[0..std.mem.len(name)];
    root.printResult(name_slice, &ctx);
}

/// Returns 1 for as long as the benchmark should run.
/// See `Context.run()`'s documentation.
export fn benchmark_run(ctx: *anyopaque) c_int {
    const c: *root.Context = @ptrCast(@alignCast(ctx));
    if (c.run()) {
        return 1;
    } else {
        return 0;
    }
}

/// Returns 1 for as long as the benchmark should run.
/// You are in charge of calling `benchmark_start_timer` and `benchmark_stop_timer`.
/// See `Context.runExplicitTiming()`'s documentation.
export fn benchmark_run_explicit_timing(ctx: *anyopaque) u8 {
    const c: *root.Context = @ptrCast(@alignCast(ctx));
    if (c.runExplicitTiming()) {
        return 1;
    } else {
        return 0;
    }
}

/// Starts the context's timer.
export fn benchmark_start_timer(ctx: *anyopaque) void {
    const c: *root.Context = @ptrCast(@alignCast(ctx));
    c.startTimer();
}

/// Stops the context's timer.
export fn benchmark_stop_timer(ctx: *anyopaque) void {
    const c: *root.Context = @ptrCast(@alignCast(ctx));
    c.stopTimer();
}
