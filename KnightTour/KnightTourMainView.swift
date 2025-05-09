import SwiftUI

struct KnightTourMainView: View {

    @State private var selectedSize: Int = 5
    @State private var selectedSolverIndex: Int = 0
    @State private var viewModel: KnightTourViewModel?
    @StateObject private var store = ViewModelStore()
    @State private var path = NavigationPath()

    let solverOptions: [(name: String, builder: (Int) -> KnightTourSolver)] = [
        ("Optimal", { OptimizedWarnsdorffSolver(size: $0) }),
        ("Random", { RandomizedWarnsdorffSolver(size: $0) }),
        ("Backtracking", { BacktrackingSolver(size: $0) })
    ]

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section {
                    ForEach(5...8, id: \.self) { size in
                        Button {
                            selectedSize = size
                        } label: {
                            HStack {
                                Text("\(size) x \(size)")
                                Spacer()
                                if size == selectedSize {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } header: {
                    Text("Board Size")
                }
                Section {
                    ForEach(0..<solverOptions.count, id: \.self) { i in
                        Button {
                            selectedSolverIndex = i
                        } label: {
                            HStack {
                                Text(solverOptions[i].name)
                                Spacer()
                                if i == selectedSolverIndex {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                } header: {
                    Text("Algorithm")
                }
                Section {
                    Button {
                        let id = UUID()
                        let solver = solverOptions[selectedSolverIndex].builder(selectedSize)
                        let vm = KnightTourViewModel(solver: solver, start: (0, 0))
                        store.map[id] = vm
                        path.append(KnightTourRoute.animation(id: id))
                    } label: {
                        Text("Start")
                    }
                }
            }
            .navigationDestination(for: KnightTourRoute.self) { route in
                switch route {
                    case .animation(let id):
                        if let viewModel = store.map[id] {
                            KnightTourBoardView(viewModel: viewModel)
                                .onAppear {
                                    viewModel.startAnimation()
                                }
                        } else {
                            ContentUnavailableView("Failed to load", systemImage: "xmark")
                        }
                }
            }
            .navigationTitle("Knight's Tour")
        }
    }

}
