import SwiftUI

struct KnightTourBoardView: View {

    @ObservedObject var viewModel: KnightTourViewModel

    var body: some View {
        VStack {
            Grid(horizontalSpacing: 2, verticalSpacing: 2) {
                ForEach(0..<viewModel.board.count, id: \.self) { i in
                    GridRow {
                        ForEach(0..<viewModel.board[i].count, id: \.self) { j in
                            ZStack {
                                Rectangle()
                                    .fill(viewModel.board[i][j] > 0 ? Color.green : Color.gray.opacity(0.3))
                                    .aspectRatio(1, contentMode: .fit)
                                    .animation(.easeInOut, value: viewModel.board[i][j])

                                if viewModel.board[i][j] > 0 {
                                    Text("\(viewModel.board[i][j])")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .transition(.scale)
                                }

                                if viewModel.currentStep > 0 {
                                    let current = viewModel.pathPrefix[viewModel.currentStep - 1]
                                    if current.x == i && current.y == j {
                                        Text("🐴")
                                            .font(.largeTitle)
                                            .transition(.scale)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            HStack {
                if viewModel.currentStep == viewModel.board.count * viewModel.board.count {
                    Button("Restart") {
                        viewModel.startAnimation()
                    }
                } else {
                    Button(viewModel.isPlaying ? "Pause" : "Continue") {
                        viewModel.isPlaying ? viewModel.pauseAnimation() : viewModel.resumeAnimation()
                    }
                }
            }
            .padding(.top)
        }
        .padding()
    }

}
