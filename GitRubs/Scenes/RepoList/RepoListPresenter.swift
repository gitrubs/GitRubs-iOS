import UIKit

protocol RepoListPresenterInput {
    func formatError(_ error: String)
    func formatRepos(_ repos: [Repo], page: Int)
}

protocol RepoListPresenterOutput: class {
    func showAlert(_ alert: UIAlertController)
    func showRepos(_ repos: [Repo], isFirstPage: Bool)
}

class RepoListPresenter: RepoListPresenterInput {
    weak var output: RepoListPresenterOutput!

    func formatError(_ error: String) {
        let alert = UIAlertController(title: "Eita!", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        output.showAlert(alert)
    }

    func formatRepos(_ repos: [Repo], page: Int) {
        output.showRepos(repos, isFirstPage: page == 1)
    }
}
