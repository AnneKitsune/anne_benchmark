#include "anne_benchmark.h"
#include <stdio.h>

void benched_fn(void *ctx) {
    while (benchmark_run(ctx)) {
    }
}

int main(int argc, char **argv) {
    benchmark_c("c test benchmark", benched_fn);
    return 0;
}


