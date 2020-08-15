import UIKit

protocol RepoListInteractorInput {
    func fetchRepos()
    func fetchNextPage()
}

protocol RepoListInteractorOutput {
    func presentRepos(_ repos: [Repo], page: Int)
    func presentError(_ error: String)
}

class RepoListInteractor: RepoListInteractorInput {
    var output: RepoListInteractorOutput!
    var worker: RepoWorkerType!

    var currentPage = 0

    // MARK: Business logic
    func fetchRepos() {
        getRepos(page: 1)
    }

    func fetchNextPage() {
        getRepos(page: currentPage + 1)
    }

    func getRepos(page: Int) {
        currentPage = page
        worker.getRepos(page: page, onSuccess: { (repos) in
            self.output.presentRepos(repos, page: page)
        }, onError: { (error) in
            self.output.presentError(error)
        })
    }
}

