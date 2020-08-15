struct GithubRepoWorker: RepoWorkerType {
    func getRepos(page: Int, onSuccess: ([Repo]) -> Void, onError: (String) -> Void) {
        onSuccess(mock())
    }

    func mock() -> [Repo] {
        return [
            Repo(name: "Repo 1", stars: 8, author: Person(name: "Pessoa deva", photo: "fotinha")),
            Repo(name: "Repo 2", stars: 6, author: Person(name: "Alguém ai", photo: "fotinha")),
            Repo(name: "Repo 3", stars: 5, author: Person(name: "Otra pessoa", photo: "fotinha")),
            Repo(name: "Repo 4", stars: 3, author: Person(name: "Eu", photo: "fotinha"))
        ]
    }
}
