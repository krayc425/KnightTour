import Foundation

enum KnightTourRoute: Hashable {

    case animation(id: UUID)

    static func ==(lhs: KnightTourRoute, rhs: KnightTourRoute) -> Bool {
        switch (lhs, rhs) {
        case let (.animation(id1), .animation(id2)):
            return id1 == id2
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case .animation(let id):
            hasher.combine(id)
        }
    }

}
