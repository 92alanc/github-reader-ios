struct Dependencies {
    
    static func repositoryRemoteDataSource() -> RepositoryRemoteDataSource {
        return RepositoryRemoteDataSourceImpl()
    }
    
    static func repositoryRepository() -> RepositoryRepository {
        return RepositoryRepositoryImpl(remoteDataSource: repositoryRemoteDataSource())
    }
    
    static func getRepositoriesUseCase() -> GetRepositoriesUseCase {
        return GetRepositoriesUseCaseImpl(repository: repositoryRepository())
    }
    
    static func repositoryListViewModel() -> RepositoryListViewModel {
        return RepositoryListViewModel(
            getRepositoriesUseCase: getRepositoriesUseCase(),
            logger: logger()
        )
    }
    
    static func logger() -> Logger {
        return LoggerImpl()
    }
}
