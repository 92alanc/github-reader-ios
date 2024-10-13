import Foundation

protocol RepositoryRemoteDataSource {
    func getRepositories() async throws -> [Repository]
}
