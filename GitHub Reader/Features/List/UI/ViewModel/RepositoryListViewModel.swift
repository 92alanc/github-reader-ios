import Foundation
import Combine // Similar to Coroutines

class RepositoryListViewModel: ObservableObject {
    
    @Published var repositories: [UIRepository] = []
    @Published var error: Error?
    
    private let getRepositoriesUseCase: GetRepositoriesUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(getRepositoriesUseCase: GetRepositoriesUseCase) {
        self.getRepositoriesUseCase = getRepositoriesUseCase
    }
    
    func getRepositories() {
        getRepositoriesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.error = error
                }
            } receiveValue: { repositories in
                self.repositories = repositories.map { $0.toUI() }
            }
            .store(in: &cancellables)
    }
}
