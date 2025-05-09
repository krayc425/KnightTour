class OptimizedWarnsdorffSolver: BaseKnightSolver {

    override func solve(from start: (x: Int, y: Int)) -> Bool {
        var pos = start
        board[pos.x][pos.y] = 0

        for step in 1..<(size * size) {
            let nextMoves = moves.map { (dx, dy) in (pos.x + dx, pos.y + dy) }
                .filter { isValid(x: $0.0, y: $0.1) }

            let sorted = nextMoves.sorted {
                degree(x: $0.0, y: $0.1) < degree(x: $1.0, y: $1.1)
            }

            guard let next = sorted.first else {
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
