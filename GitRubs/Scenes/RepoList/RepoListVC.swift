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
    let refresh = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupUI()
        startLoading()
        refreshList()
    }

    func setupUI() {
        setupTableView()
        setupNavigationBar()
    }

    func setupNavigationBar() {
        navigationItem.title = "GitRubs"
        navigationItem.largeTitleDisplayMode = .never

        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(RepoCell.self, forCellReuseIdentifier: RepoCell.identifier)

        // Pull to Refresh
        refresh.tintColor = .black
        refresh.attributedTitle = NSAttributedString(string: "Loading...")
        refresh.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.refreshControl = refresh

        // Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.setTop(to: view.topAnchor)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.setBottom(to: view.bottomAnchor)
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    @objc func refreshList() {
        refresh.attributedTitle = NSAttributedString(string: "Loading...")
        output.askForRepos(page: 1)
    }

    func startLoading() {
        refresh.beginRefreshing()
    }

    func stopLoading() {
        refresh.endRefreshing()
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
    }

    func updateList() {
        tableView.reloadData()
        stopLoading()
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
