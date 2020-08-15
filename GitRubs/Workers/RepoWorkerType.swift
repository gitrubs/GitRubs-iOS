protocol RepoWorkerType {
    func getRepos(page: Int, onSuccess: @escaping ([Repo]) -> Void, onError: @escaping (String) -> Void)
}
