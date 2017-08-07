import XCTest
@testable import CMiniSat

class CMiniSatTests: XCTestCase {
    func testIncrementalSolving() {
        let minisat = minisat_init()
        
        let a = minisat_new(minisat)
        let b = minisat_new(minisat)
        
        XCTAssertNotEqual(a, b)
        XCTAssertEqual(minisat_max_var(minisat), 2)
        
        minisat_add(minisat, a)
        minisat_add(minisat, b)
        minisat_add(minisat, 0)
        
        minisat_add(minisat, -b)
        minisat_add(minisat, 0)
        
        XCTAssertTrue(minisat_solve(minisat))
        XCTAssertTrue(minisat_value(minisat, a) > 0)
        XCTAssertTrue(minisat_value(minisat, b) < 0)
        
        minisat_assume(minisat, b)
        
        XCTAssertFalse(minisat_solve(minisat))
        XCTAssertFalse(minisat_failed(minisat, a))
        XCTAssertTrue(minisat_failed(minisat, b))
        
        XCTAssertTrue(minisat_solve(minisat))
    }


    static var allTests : [(String, (CMiniSatTests) -> () throws -> Void)] {
        return [
            ("testIncrementalSolving", testIncrementalSolving),
        ]
    }
}
