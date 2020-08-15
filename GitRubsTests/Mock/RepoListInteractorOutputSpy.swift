@testable import GitRubs

class RepoListInteractorOutputSpy: RepoListInteractorOutput {
    @Spy var invokedPresentRepos: (repos: [Repo], page: Int)?
    @Spy var invokedPresentError: String?

    func presentRepos(_ repos: [Repo], page: Int) {
        invokedPresentRepos = (repos, page)
    }

    func presentError(_ error: String) {
        invokedPresentError = error
    }
}
