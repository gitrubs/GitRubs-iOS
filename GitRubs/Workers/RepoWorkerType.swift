protocol RepoWorkerType {
    func getRepos(page: Int, onSuccess: ([Repo]) -> Void, onError: (String) -> Void)
}
