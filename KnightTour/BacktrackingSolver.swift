class BacktrackingSolver: BaseKnightSolver {

    override func solve(from start: (x: Int, y: Int)) -> Bool {
        board[start.x][start.y] = 0
        return backtrack(x: start.x, y: start.y, move: 1)
    }

    private func backtrack(x: Int, y: Int, move: Int) -> Bool {
        if move == size * size {
            return true
        }

        for (dx, dy) in moves {
            let nx = x + dx, ny = y + dy
            if isValid(x: nx, y: ny) {
                board[nx][ny] = move
                if backtrack(x: nx, y: ny, move: move + 1) {
                    return true
                }
                board[nx][ny] = -1
            }
        }

        return false
    }

}
