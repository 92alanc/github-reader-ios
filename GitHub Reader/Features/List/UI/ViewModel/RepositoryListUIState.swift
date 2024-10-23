struct RepositoryListUIState {
    private(set) var isLoading: Bool = false
    private(set) var repositories: [UIRepository]? = nil
    private(set) var errorMessage: String? = nil
    
    func onLoading() -> Self {
        return Self(
            isLoading: true,
            repositories: nil,
            errorMessage: nil
        )
    }
    
    func onFinishedLoading() -> Self {
        return Self(
            isLoading: false,
            repositories: repositories,
            errorMessage: errorMessage
        )
    }
    
    func onRepositoriesReceived(repositories: [UIRepository]) -> Self {
        return Self(
            isLoading: isLoading,
            repositories: repositories,
            errorMessage: nil
        )
    }
    
    func onError(errorMessage: String) -> Self {
        return Self(
            isLoading: isLoading,
            repositories: nil,
            errorMessage: errorMessage
        )
    }
}
