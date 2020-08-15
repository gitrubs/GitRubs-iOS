import UIKit

// MARK: Connect View, Interactor, and Presenter
extension RepoListVC: RepoListPresenterOutput {
    func showAlert(_ alert: UIAlertController) {
        DispatchQueue.main.async {
            self.displayAlert(alert)
        }
    }

    func showRepos(_ repos: [Repo], isFirstPage: Bool) {
        DispatchQueue.main.async {
            self.displayRepos(repos, isFirstPage: isFirstPage)
        }
    }
}

extension RepoListInteractor: RepoListVCOutput {
    func askForRepos(page: Int) {
        fetchRepos(page: page)
    }
}

extension RepoListPresenter: RepoListInteractorOutput {
    func presentRepos(_ repos: [Repo], page: Int) {
        formatRepos(repos, page: page)
    }

    func presentError(_ error: String) {
        formatError(error)
    }
}

extension RepoListVC {
    // MARK: Configuration
    func configure() {
        let presenter = RepoListPresenter()
        presenter.output = self

        let interactor = RepoListInteractor()
        interactor.output = presenter
        interactor.worker = GithubRepoWorker()

        self.output = interactor
    }
}

