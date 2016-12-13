import CMiniSat
import SATSolver

public class MiniSat: SATSolver {
    public typealias Literal = Int32
    
    let minisat: OpaquePointer
    
    public required init() {
        minisat = minisat_init()
    }
    
    deinit {
        minisat_free(minisat)
    }
    
    public var maxVar: Literal {
        return minisat_max_var(minisat)
    }
    
    public func new() -> Literal {
        return minisat_new(minisat)
    }

    public func add(literal: Literal) {
        minisat_add(minisat, literal)
    }
    
    public func assume(literal: Literal) {
        minisat_assume(minisat, literal)
    }
    
    public func solve() -> SATSolverResult {
        if minisat_solve(minisat) {
            return .satisfiable
        } else {
            return .unsatisfiable
        }
    }
    
    public func value(of literal: Literal) -> SATSolverLiteralValue {
        let value = minisat_value(minisat, literal)
        if value < 0 {
            return .negative
        } else if value > 0 {
            return .positive
        } else {
            return .unassigned
        }
    }
    
    public func failed(literal: Literal) -> Bool {
        return minisat_failed(minisat, literal)
    }
}
