class RepositoryRepositoryImpl: RepositoryRepository {
    
    private let remoteDataSource: RepositoryRemoteDataSource
    
    init(remoteDataSource: RepositoryRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getRepositories() async throws -> [Repository] {
        return try await remoteDataSource.getRepositories()
    }
}
