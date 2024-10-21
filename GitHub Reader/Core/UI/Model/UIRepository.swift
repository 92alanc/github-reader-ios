import Foundation

struct UIRepository: Identifiable {
    let id: Int
    let name: String
    let description: String?
    let url: String
    let starCount: Int
    let ownerLogin: String
    let ownerAvatarUrl: URL
}
