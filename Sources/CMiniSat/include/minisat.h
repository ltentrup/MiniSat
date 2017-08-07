#pragma once

#include <stdbool.h>

typedef struct MiniSat MiniSat;

MiniSat* minisat_init(void);
void minisat_free(MiniSat*);

int minisat_new(MiniSat*);
int minisat_max_var(MiniSat*);
void minisat_add(MiniSat*, int);
void minisat_assume(MiniSat*, int);
bool minisat_solve(MiniSat*);
int minisat_value(MiniSat*, int);
bool minisat_failed(MiniSat*, int);
