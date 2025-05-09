import SwiftUI

@main
struct KnightTourApp: App {

    var body: some Scene {
        WindowGroup {
            KnightTourMainView()
                #if os(macOS)
                .frame(minWidth: 500, minHeight: 600)
                #endif
        }
    }

}
