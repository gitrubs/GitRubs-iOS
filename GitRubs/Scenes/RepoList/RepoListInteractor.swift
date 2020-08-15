import UIKit

protocol RepoListInteractorInput {
    func fetchRepos(page: Int)
}

protocol RepoListInteractorOutput {
    func presentRepos(_ repos: [Repo], page: Int)
    func presentError(_ error: String)
}

class RepoListInteractor: RepoListInteractorInput {
    var output: RepoListInteractorOutput!
    var worker: RepoWorkerType!

    // MARK: Business logic
    func fetchRepos(page: Int) {
        worker.getRepos(page: page, onSuccess: { (repos) in
            self.output.presentRepos(repos, page: page)
        }, onError: { (error) in
            self.output.presentError(error)
        })
    }
}

