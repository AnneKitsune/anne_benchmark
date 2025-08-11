#ifdef __cplusplus
extern "C" {
#endif

typedef void (*BenchFn)(void *);

extern void benchmark_c(char *name, BenchFn fn);
extern int benchmark_run(void *ctx);
extern int benchmark_run_explicit_timing(void *ctx);
extern void benchmark_start(void *ctx);
extern void benchmark_stop(void *ctx);

#ifdef __cplusplus
}
#endif


