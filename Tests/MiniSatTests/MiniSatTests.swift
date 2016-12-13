import XCTest
@testable import MiniSat

class MiniSatTests: XCTestCase {
    func testIncrementalSolving() {
        let minisat = MiniSat()
        
        let a = minisat.new()
        let b = minisat.new()
        XCTAssertNotEqual(a, b)
        
        minisat.add(clause: [a, b])
        minisat.add(clause: [-b])
        XCTAssertEqual(minisat.solve(), .satisfiable)
        XCTAssertEqual(minisat.value(of: a), .positive)
        XCTAssertEqual(minisat.value(of: b), .negative)
        
        minisat.assume(literal: b)
        XCTAssertEqual(minisat.solve(), .unsatisfiable)
        XCTAssertFalse(minisat.failed(literal: a))
        XCTAssertTrue(minisat.failed(literal: b))
        
        XCTAssertEqual(minisat.solve(), .satisfiable)
    }


    static var allTests : [(String, (MiniSatTests) -> () throws -> Void)] {
        return [
            ("testIncrementalSolving", testIncrementalSolving),
        ]
    }
}
