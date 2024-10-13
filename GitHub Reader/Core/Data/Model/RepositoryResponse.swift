struct RepositoryResponse: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String?
    let url: String
    let starCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case url = "html_url"
        case starCount = "stargazers_count"
    }
}
