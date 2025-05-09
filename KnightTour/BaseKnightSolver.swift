import Foundation

class BaseKnightSolver: KnightTourSolver {

    let size: Int
    var board: [[Int]]

    required init(size: Int) {
        self.size = size
        self.board = Array(repeating: Array(repeating: -1, count: size), count: size)
    }

    func solve(from start: (x: Int, y: Int)) -> Bool {
        fatalError("Override in subclass")
    }

}
