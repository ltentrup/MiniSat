# Swift Bindings for MiniSat

A swifty wrapper around the [MiniSat](http://minisat.se) SAT solver by Niklas Een and Niklas Sorensson.

## Example Usage

```swift
import MiniSat

let minisat = MiniSat()
    
let a = minisat.new()
let b = minisat.new()
    
minisat.add(clause: [a, b])
minisat.add(clause: [-b])
minisat.solve() // -> .satisfiable
minisat.value(of: a) // -> .positive
minisat.value(of: b) // -> .negative
    
minisat.assume(literal: b)
minisat.solve() // -> .unsatisfiable
minisat.failed(literal: a) // -> false
minisat.failed(literal: b) // -> true
    
minisat.solve() // -> .satisfiable
```

# Installation

## Swift Package Manager

```swift
.Package(url: "https://github.com/ltentrup/MiniSat.git", majorVersion: 0, minor: 1)
```

