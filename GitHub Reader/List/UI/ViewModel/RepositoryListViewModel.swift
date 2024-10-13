import Foundation
import Combine // Similar to Coroutines

class RepositoryListViewModel: ObservableObject {
    
    @Published var repositories: [RepositoryResponse] = []
    private var cancellable: AnyCancellable?
    
    func getRepositories() {
        guard let url = URL(string: "https://api.github.com/users/92alanc/repos") else {
            print("Invalid URL")
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [RepositoryResponse].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] repositories in
                self?.repositories = repositories
            }
    }
}
