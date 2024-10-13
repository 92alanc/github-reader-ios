import SwiftUI

struct RepositoryDetailsView: View {
    let repository: RepositoryResponse
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let description = repository.description {
                Text(description)
                    .font(.body)
            }
            
            HStack {
                Text(verbatim: .starCountFormat(repository.starCount))
                Spacer()
                Link(
                    String.viewOnGitHub,
                    destination: URL(string: repository.url)!
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

struct RepositoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailsView(
            repository: RepositoryResponse(
                id: 1,
                name: "Carcadas Alborghetti",
                description: nil,
                url: "https://test.com",
                starCount: 3
            )
        )
    }
}
