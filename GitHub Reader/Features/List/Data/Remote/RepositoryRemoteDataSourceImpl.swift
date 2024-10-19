import Combine
import Foundation

class RepositoryRemoteDataSourceImpl: RepositoryRemoteDataSource {
    
    private let baseURLProvider: BaseURLProvider
    private let logger: Logger
    
    init(
        baseURLProvider: BaseURLProvider,
        logger: Logger
    ) {
        self.baseURLProvider = baseURLProvider
        self.logger = logger
    }
    
    func getRepositories() async throws -> [Repository] {
        let url = baseURLProvider.getBaseURL()
        let (data, response) = try await URLSession.shared.data(from: url)
        let json = String(data: data, encoding: .utf8) ?? ""
        logger.log(json)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let list = try JSONDecoder().decode([RepositoryResponse].self, from: data)
        return list.map { $0.toDomain() }
    }
}
