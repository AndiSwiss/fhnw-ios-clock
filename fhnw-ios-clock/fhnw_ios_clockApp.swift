import SwiftUI

@main
struct fhnw_ios_clockApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: ClockViewModel())
        }
    }
}
