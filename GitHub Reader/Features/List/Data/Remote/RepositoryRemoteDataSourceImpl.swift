import Combine
import Foundation

class RepositoryRemoteDataSourceImpl: RepositoryRemoteDataSource {
    
    private let baseURLProvider: BaseURLProvider
    
    init(baseURLProvider: BaseURLProvider) {
        self.baseURLProvider = baseURLProvider
    }
    
    func getRepositories() async throws -> [Repository] {
        let url = baseURLProvider.getBaseURL()
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let list = try JSONDecoder().decode([RepositoryResponse].self, from: data)
        return list.map { $0.toDomain() }
    }
}
