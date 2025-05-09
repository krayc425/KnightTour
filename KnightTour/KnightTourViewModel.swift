import SwiftUI
import Combine

class ViewModelStore: ObservableObject {

    @Published var map: [UUID: KnightTourViewModel] = [:]

}

class KnightTourViewModel: ObservableObject {

    @Published var board: [[Int]]
    @Published var currentStep: Int = 0
    @Published var isPlaying: Bool = false

    private(set) var path: [(x: Int, y: Int)] = []
    private var size: Int
    private var timer: AnyCancellable?

    var pathPrefix: [(x: Int, y: Int)] {
        Array(path.prefix(currentStep))
    }

    init(solver: KnightTourSolver, start: (x: Int, y: Int)) {
        self.size = solver.size
        self.board = Array(repeating: Array(repeating: -1, count: size), count: size)

        if solver.solve(from: start) {
            let allCoords = (0..<size).flatMap { i in (0..<size).map { j in (i, j) } }
            self.path = allCoords
                .filter { solver.board[$0.0][$0.1] >= 0 }
                .sorted { solver.board[$0.0][$0.1] < solver.board[$1.0][$1.1] }
        }
    }

    func startAnimation(speed: Double = 0.4) {
        resetBoard()
        isPlaying = true
        timer = Timer.publish(every: speed, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.stepForward()
            }
    }

    func pauseAnimation() {
        timer?.cancel()
        isPlaying = false
    }

    func resumeAnimation(speed: Double = 0.4) {
        isPlaying = true
        timer = Timer.publish(every: speed, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.stepForward()
            }
    }

    func resetBoard() {
        timer?.cancel()
        isPlaying = false
        currentStep = 0
        board = Array(repeating: Array(repeating: -1, count: size), count: size)
    }

    func stepForward() {
        guard currentStep < path.count else {
            timer?.cancel()
            isPlaying = false
            return
        }
        let (x, y) = path[currentStep]
        board[x][y] = currentStep + 1
        currentStep += 1
    }

}
