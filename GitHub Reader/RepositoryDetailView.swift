import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let description = repository.description {
                Text(description)
                    .font(.body)
            }
            
            HStack {
                Text(verbatim: .starCountFormat(repository.stargazers_count))
                Spacer()
                Link(
                    String.viewOnGitHub,
                    destination: URL(string: repository.html_url)!
                )
                .foregroundColor(.blue)
            }
            .font(.subheadline)
            
            Spacer()
        }
        .padding()
        .navigationTitle(repository.name)
    }
}

struct RepositoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailView(
            repository: Repository(
                id: 1,
                name: "Carcadas Alborghetti",
                description: nil,
                html_url: "https://test.com",
                stargazers_count: 3
            )
        )
    }
}
