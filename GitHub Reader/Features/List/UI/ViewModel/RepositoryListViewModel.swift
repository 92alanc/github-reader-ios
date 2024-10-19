import Foundation
import Combine // Similar to Coroutines

class RepositoryListViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var repositories: [UIRepository] = []
    @Published var errorMessage: String? = nil
    
    private let getRepositoriesUseCase: GetRepositoriesUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(getRepositoriesUseCase: GetRepositoriesUseCase) {
        self.getRepositoriesUseCase = getRepositoriesUseCase
    }
    
    func getRepositories() {
        getRepositoriesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.isLoading = true
            }, receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            })
            .catch { [weak self] error -> Just<[Repository]> in
                print(error)
                self?.errorMessage = error.localizedDescription
                return Just([])
            }
            .sink { [weak self] repositories in
                self?.repositories = repositories.map { $0.toUI() }
            }
            .store(in: &cancellables)
    }
}
