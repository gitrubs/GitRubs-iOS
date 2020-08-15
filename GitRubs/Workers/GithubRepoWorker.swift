import Foundation

struct GithubRepoWorker: RepoWorkerType {
    let baseUrl = "https://api.github.com/search/repositories?q=language:swift&sort=stars&per_page=20"

    func getRepos(page: Int, onSuccess: @escaping ([Repo]) -> Void, onError: @escaping (String) -> Void) {
        guard let url = URL(string: "\(baseUrl)&page=\(page)") else {
            onError("URL inválida :(")
            return
        }
        let session = URLSession(configuration: .default)

        session.dataTask(with: url) { (data, urlResponse, error) in
            if let error = error {
                onError(error.localizedDescription)
                return
            }

            guard let data = data,
                let response = urlResponse as? HTTPURLResponse,
                response.statusCode == 200,
                let responseData = try? JSONDecoder().decode(GithubReposResponse.self, from: data)
                else {
                    onError("Algo deu errado com a resposta: \(urlResponse?.description ?? "Null")")
                    return
            }

            onSuccess(responseData.toModel())
        }.resume()
    }

    struct GithubReposResponse: Codable {
        let items: [GithubRepo]

        func toModel() -> [Repo] {
            return items.map { $0.toModel() }
        }
    }

    struct GithubRepo: Codable {
        let name: String
        let owner: GithubUser
        let stargazers_count: Int

        func toModel() -> Repo {
            return Repo(name: name, stars: stargazers_count, author: owner.toModel())
        }
    }

    struct GithubUser: Codable {
        let login: String
        let avatar_url: String

        func toModel() -> Person {
            return Person(name: login, photo: avatar_url)
        }
    }
}
