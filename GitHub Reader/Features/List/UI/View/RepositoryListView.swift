import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var viewModel: RepositoryListViewModel
    
    var body: some View {
        NavigationView {
            if (viewModel.isLoading) {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else if (!viewModel.repositories.isEmpty) {
                List(viewModel.repositories) { repository in
                    NavigationLink(destination: RepositoryDetailsView(repository: repository)) {
                        VStack(alignment: .leading) {
                            Text(repository.name)
                                .font(.headline)
                            Text(repository.description ?? .noDescription)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .navigationTitle(
                    Text(verbatim: .repositoryListTitle)
                )
            }
        }
        .onAppear {
            viewModel.getRepositories()
        }
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView(
            viewModel: container.resolve(RepositoryListViewModel.self)!
        )
    }
}
