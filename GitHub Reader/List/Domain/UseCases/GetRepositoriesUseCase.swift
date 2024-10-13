import Combine

protocol GetRepositoriesUseCase {
    
    func execute() -> AnyPublisher<[Repository], Error>
}
