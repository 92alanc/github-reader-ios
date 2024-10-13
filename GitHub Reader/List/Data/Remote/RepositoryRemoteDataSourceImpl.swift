import Combine
import Foundation

class RepositoryRemoteDataSourceImpl: RepositoryRemoteDataSource {
    
    func getRepositories() async throws -> [Repository] {
        let url = URL(string: "https://api.github.com/users/92alanc/repos")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let list = try JSONDecoder().decode([RepositoryResponse].self, from: data)
        return list.map { $0.toDomain() }
    }
}
