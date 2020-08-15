@testable import GitRubs

class MockRepoWorker: RepoWorkerType {
    var shouldFail = false
    var mockResponse: [Repo] = []
    var mockError: String = "Error"

    @Spy var invokedGetReposPage: Int?

    func getRepos(page: Int, onSuccess: @escaping ([Repo]) -> Void, onError: @escaping (String) -> Void) {
        invokedGetReposPage = page
        shouldFail ? onError(mockError) : onSuccess(mockResponse)
    }
}
