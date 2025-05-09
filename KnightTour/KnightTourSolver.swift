import Foundation

protocol KnightTourSolver {

    var size: Int { get }
    var board: [[Int]] { get set }

    init(size: Int)
    func solve(from start: (x: Int, y: Int)) -> Bool

}

extension KnightTourSolver {

    var moves: [(Int, Int)] {
        [
            (2, 1), (1, 2), (-1, 2), (-2, 1),
            (-2, -1), (-1, -2), (1, -2), (2, -1)
        ]
    }

    func isValid(x: Int, y: Int) -> Bool {
        x >= 0 && x < size && y >= 0 && y < size && board[x][y] == -1
    }

}
