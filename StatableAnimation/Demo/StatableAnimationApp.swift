import SwiftUI

@main
struct StatableAnimationApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: LoaderView.ViewModel())
        }
    }
}
