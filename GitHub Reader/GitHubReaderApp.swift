import SwiftUI

@main
struct GitHubReaderApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = Dependencies.repositoryListViewModel()
            RepositoryListView(viewModel: viewModel)
        }
    }
}
