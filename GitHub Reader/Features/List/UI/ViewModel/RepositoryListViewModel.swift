import Foundation
import Combine

class RepositoryListViewModel: ObservableObject {
    
    @Published private(set) var state = RepositoryListUIState()
    
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
                self?.state = (self?.state.onLoading())!
            }, receiveCompletion: { [weak self] _ in
                self?.logger.log("Completed")
                self?.state = (self?.state.onFinishedLoading())!
            })
            .catch { [weak self] error -> Just<[Repository]> in
                self?.logger.log("Something went wrong", error)
                self?.state = (self?.state.onError(errorMessage: error.localizedDescription))!
                return Just([])
            }
            .sink { [weak self] repositories in
                let repositories = repositories.map { $0.toUI() }
                self?.logger.log("Fetched \(repositories.count) repositories")
                self?.state = (self?.state.onRepositoriesReceived(repositories: repositories))!
            }
            .store(in: &cancellables)
    }
}
