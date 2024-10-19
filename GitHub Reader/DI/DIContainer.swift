import Swinject

let container = Container()

func setUpDIContainer() {
    container.register(Logger.self) { _ in
        LoggerImpl()
    }
    
    container.register(BaseURLProvider.self) { _ in
        BaseURLProviderImpl()
    }
    
    container.register(RepositoryRemoteDataSource.self) { resolver in
        RepositoryRemoteDataSourceImpl(
            baseURLProvider: resolver.resolve(BaseURLProvider.self)!,
            logger: resolver.resolve(Logger.self)!
        )
    }
    
    container.register(RepositoryRepository.self) { resolver in
        RepositoryRepositoryImpl(
            remoteDataSource: resolver.resolve(RepositoryRemoteDataSource.self)!
        )
    }
    
    container.register(GetRepositoriesUseCase.self) { resolver in
        GetRepositoriesUseCaseImpl(
            repository: resolver.resolve(RepositoryRepository.self)!
        )
    }
    
    container.register(RepositoryListViewModel.self) { resolver in
        RepositoryListViewModel(
            getRepositoriesUseCase: resolver.resolve(GetRepositoriesUseCase.self)!,
            logger: resolver.resolve(Logger.self)!
        )
    }
}
