import Foundation
import Combine // Similar to Coroutines

class RepositoryListViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var repositories: [UIRepository] = []
    @Published var errorMessage: String? = nil
    
    private let getRepositoriesUseCase: GetRepositoriesUseCase
    private let logger: Logger
    private var cancellables = Set<AnyCancellable>()
    
    init(
        getRepositoriesUseCase: GetRepositoriesUseCase,
        logger: Logger
    ) {
        self.getRepositoriesUseCase = getRepositoriesUseCase
        self.logger = logger
    }
    
    func getRepositories() {
        getRepositoriesUseCase.execute()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.logger.log("Loading...")
                self?.isLoading = true
            }, receiveCompletion: { [weak self] _ in
                self?.logger.log("Completed")
                self?.isLoading = false
            })
            .catch { [weak self] error -> Just<[Repository]> in
                self?.logger.log("Something went wrong", error)
                self?.errorMessage = error.localizedDescription
                return Just([])
            }
            .sink { [weak self] repositories in
                self?.logger.log("Fetched \(repositories.count) repositories")
                self?.repositories = repositories.map { $0.toUI() }
            }
            .store(in: &cancellables)
    }
}
