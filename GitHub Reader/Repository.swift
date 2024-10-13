struct Repository: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String?
    let html_url: String
    let stargazers_count: Int
}
