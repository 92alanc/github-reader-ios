import SwiftUI

@main
struct GitHubReaderApp: App {
    init() {
        setUpDIContainer()
    }
    
    var body: some Scene {
        WindowGroup {
            RepositoryListView(viewModel: container.resolve(RepositoryListViewModel.self)!)
        }
    }
}
