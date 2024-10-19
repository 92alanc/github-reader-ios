import Foundation

class BaseURLProviderImpl: BaseURLProvider {
    
    private static let baseURL = "https://api.github.com/users/92alanc/repos"
    
    func getBaseURL() -> URL {
        let url = BaseURLProviderImpl.baseURL
        return URL(string: url)!
    }
}
