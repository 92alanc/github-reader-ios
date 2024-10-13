extension Repository {
    func toUI() -> UIRepository {
        return UIRepository(
            id: id,
            name: name,
            description: description,
            url: url,
            starCount: starCount
        )
    }
}
