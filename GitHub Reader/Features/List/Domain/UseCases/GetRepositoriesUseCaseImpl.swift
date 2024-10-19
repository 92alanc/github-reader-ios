import Combine

class GetRepositoriesUseCaseImpl: GetRepositoriesUseCase {
    
    private let repository: RepositoryRepository
    
    init(repository: RepositoryRepository) {
        self.repository = repository
    }
    
    func execute() -> AnyPublisher<[Repository], Error> {
        Future { promise in
            Task {
                do {
                    let repositories = try await self.repository.getRepositories()
                    promise(.success(repositories))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
