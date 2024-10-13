import Foundation

extension String {
    static let repositoryListTitle = NSLocalizedString(
        "repository_list_title",
        comment: ""
    )
    
    static let noDescription = NSLocalizedString(
        "no_description",
        comment: ""
    )
    
    static func starCountFormat(_ count: Int) -> String {
        return localised("star_count_format", count)
    }
    
    static let viewOnGitHub = NSLocalizedString(
        "view_on_github",
        comment: ""
    )
    
    private static func localised(_ key: String, _ args: CVarArg...) -> String {
        let localisedString = NSLocalizedString(key, comment: "")
        return String(format: localisedString, arguments: args)
    }
}
