import SwiftUI

struct RepositoryDetailsView: View {
    let repository: UIRepository
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
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
            
            HStack {
                AsyncImage(url: repository.ownerAvatarUrl) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 2))
                        .shadow(radius: 10)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 60, height: 60)
                
                Text(repository.ownerLogin)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(repository.name)
    }
}

struct RepositoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailsView(
            repository: UIRepository(
                id: 1,
                name: "Carcadas Alborghetti",
                description: nil,
                url: "https://test.com",
                starCount: 3,
                ownerLogin: "92alanc",
                ownerAvatarUrl: URL(string: "https://avatars.githubusercontent.com/u/33719607?v=4")!
            )
        )
    }
}
