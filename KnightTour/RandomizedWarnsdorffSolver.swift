class RandomizedWarnsdorffSolver: BaseKnightSolver {

    override func solve(from start: (x: Int, y: Int)) -> Bool {
        var pos = start
        board[pos.x][pos.y] = 0

        for step in 1..<(size * size) {
            let nextMoves = moves.map { (dx, dy) in (pos.x + dx, pos.y + dy) }
                .filter { isValid(x: $0.0, y: $0.1) }

            let minDegree = nextMoves.map { degree(x: $0.0, y: $0.1) }.min() ?? Int.max
            let candidates = nextMoves.filter { degree(x: $0.0, y: $0.1) == minDegree }

            guard let next = candidates.randomElement() else {
                return false
            }

            board[next.0][next.1] = step
            pos = next
        }
        return true
    }

    private func degree(x: Int, y: Int) -> Int {
        moves.map { (dx, dy) in (x + dx, y + dy) }
             .filter { isValid(x: $0.0, y: $0.1) }
             .count
    }

}
