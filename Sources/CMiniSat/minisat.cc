extern "C" {
#include "minisat.h"
}

#include "Solver.h"

using namespace Minisat;


struct MiniSat {
    Solver instance;
    vec<Lit> clause;
    vec<Lit> assumptions;
    bool last_sat;
};

MiniSat* minisat_init() {
    MiniSat* solver = new MiniSat;
    solver->last_sat = false;
    return solver;
}

void minisat_free(MiniSat* solver) {
    delete solver;
}

int minisat_new(MiniSat* solver) {
    // minisat variables start at 0
    return solver->instance.newVar() + 1;
}

int minisat_max_var(MiniSat* solver) {
    return solver->instance.nVars();
}

static Lit lit_from_int(int literal) {
    bool neg = literal < 0;
    int var = neg ? -literal : literal;
    
    return mkLit(var - 1, neg);
}

void minisat_add(MiniSat* solver, int literal) {
    if (literal == 0) {
        solver->instance.addClause(solver->clause);
        solver->clause.clear();
    } else {
        Lit l = lit_from_int(literal);
        solver->clause.push(l);
    }
}

bool minisat_solve(MiniSat* solver) {
    if (solver->last_sat) {
        solver->assumptions.clear();
    }
    solver->last_sat = true;
    return solver->instance.solve(solver->assumptions);
}

int minisat_value(MiniSat* solver, int literal) {
    lbool res = solver->instance.modelValue(lit_from_int(literal));
    if (res == l_True) {
        return 1;
    } else if (res == l_False) {
        return -1;
    } else {
        assert(res == l_Undef);
        return 0;
    }
}

void minisat_assume(MiniSat* solver, int literal) {
    if (solver->last_sat) {
        solver->last_sat = false;
        solver->assumptions.clear();
    }
    solver->assumptions.push(lit_from_int(literal));
}

bool minisat_failed(MiniSat* solver, int literal) {
    LSet& conflict = solver->instance.conflict;
    return conflict.has(~lit_from_int(literal));
}