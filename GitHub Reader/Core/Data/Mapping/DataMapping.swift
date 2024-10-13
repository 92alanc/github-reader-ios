extension RepositoryResponse {
    func toDomain() -> Repository {
        return Repository(
            id: id,
            name: name,
            description: description,
            url: url,
            starCount: starCount
        )
    }
}