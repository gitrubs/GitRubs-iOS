import UIKit
@testable import GitRubs

class RepoListPresenterOutputSpy: RepoListPresenterOutput {
    @Spy var invokedShowRepos: (repos: [Repo], isFirstPage: Bool)?
    @Spy var invokedShowAlert: UIAlertController?

    func showRepos(_ repos: [Repo], isFirstPage: Bool) {
        invokedShowRepos = (repos, isFirstPage)
    }
    
    func showAlert(_ alert: UIAlertController) {
        invokedShowAlert = alert
    }
}
