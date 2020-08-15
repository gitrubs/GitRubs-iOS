import UIKit

protocol RepoListVCInput {
    func displayAlert(_ alert: UIAlertController)
    func displayRepos(_ repos: [Repo], isFirstPage: Bool)
}

protocol RepoListVCOutput {
    func askForRepos(page: Int)
}

class RepoListVC: UIViewController {
    var output: RepoListVCOutput!
    var repos: [Repo] = []

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupUI()
        output.askForRepos(page: 1)
    }

    func setupUI() {
        setupTableView()
        setupNavigationBar()
    }

    func setupNavigationBar() {
        navigationItem.title = "GitRubs"
        navigationItem.largeTitleDisplayMode = .always

        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.identifier)

        // Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTop(to: view.topAnchor)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.setBottom(to: view.bottomAnchor)
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    func updateList() {
        tableView.reloadData()
    }
}

extension RepoListVC: RepoListVCInput {
    func displayRepos(_ repos: [Repo], isFirstPage: Bool) {
        if isFirstPage { self.repos.removeAll() }
        self.repos.append(contentsOf: repos)
        updateList()
    }

    func displayAlert(_ alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }
}

extension RepoListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as! RepoCell
        let repo = repos[indexPath.row]

        cell.configure(repo: repo)

        return cell
    }
}
