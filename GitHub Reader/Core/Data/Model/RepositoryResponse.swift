struct RepositoryResponse: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String?
    let url: String
    let starCount: Int
    let owner: OwnerResponse
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case owner
        case url = "html_url"
        case starCount = "stargazers_count"
    }
}
