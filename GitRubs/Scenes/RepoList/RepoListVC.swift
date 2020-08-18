import UIKit

protocol RepoListVCInput {
    func displayAlert(_ alert: UIAlertController)
    func displayRepos(_ repos: [Repo], isFirstPage: Bool)
}

protocol RepoListVCOutput {
    func askForRepos()
    func askForNextPage()
}

class RepoListVC: UIViewController {
    var output: RepoListVCOutput!
    var repos: [Repo] = []
    var isLoading: Bool = false

    let tableView: UITableView = {
        let table = UITableView()
        table.allowsSelection = false
        table.separatorStyle = .none
        table.register(RepoCell.self, forCellReuseIdentifier: RepoCell.identifier)
        table.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.identifier)
        return table
    }()

    let refresh: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.tintColor = .black
        refresh.attributedTitle = NSAttributedString(string: "Loading...")
        return refresh
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupUI()
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
        tableView.delegate = self

        // Pull to Refresh
        refresh.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.refreshControl = refresh

        // Constraints
        tableView.setCodable()
        tableView.setTop(to: view.topAnchor)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.setBottom(to: view.bottomAnchor)
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    @objc func refreshList() {
        refresh.attributedTitle = NSAttributedString(string: "Carregando...")
        isLoading = true
        output.askForRepos()
    }

    func loadNextPage() {
        isLoading = true
        output.askForNextPage()
    }

    func stopLoading() {
        refresh.endRefreshing()
        refresh.attributedTitle = NSAttributedString(string: "Puxe para atualizar")
    }

    func updateList() {
        tableView.reloadData()
        isLoading = false
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
        present(alert, animated: false, completion: nil)
    }
}

extension RepoListVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height

        if (offsetY > contentHeight - scrollView.frame.height - 20) && !isLoading {
            loadNextPage()
        }
    }
}

extension RepoListVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? repos.count : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: LoadingCell.identifier, for: indexPath) as! LoadingCell
            cell.spinner.startAnimating()
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: RepoCell.identifier, for: indexPath) as! RepoCell
        let repo = repos[indexPath.row]

        cell.configure(repo: repo)

        return cell
    }
}
