import XCTest
@testable import GitRubs

class RepoListVCTests: XCTestCase {
    var sut: RepoListVC!
    var output: RepoListVCOutputSpy!
    
    override func setUp() {
        sut = RepoListVC()
        output = RepoListVCOutputSpy()
        
        sut.output = output
    }

    override func tearDown() {
        sut = nil
    }

    func test_loadNextPage_callsOutput() {
        sut.loadNextPage()
        
        XCTAssertEqual(sut.isLoading, true)
        XCTAssertEqual(output.$invokedAskForNextPage.value, true)
    }

    func test_refreshList_callsOutput() {
        sut.refreshList()
        
        XCTAssertEqual(sut.isLoading, true)
        XCTAssertEqual(output.$invokedAskForRepos.value, true)
        XCTAssertEqual(sut.refresh.attributedTitle?.string, "Carregando...")
    }
    
    func test_stopLoading_stopsRefreshControl() {
        sut.refresh.beginRefreshing()
        XCTAssertEqual(sut.refresh.isRefreshing, true)
        
        sut.stopLoading()
        
        XCTAssertEqual(sut.refresh.isRefreshing, false)
        XCTAssertEqual(sut.refresh.attributedTitle?.string, "Puxe para atualizar")
    }
    
    func test_updateList_stopsLoading() {
        sut.refresh.beginRefreshing()
        XCTAssertEqual(sut.refresh.isRefreshing, true)
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
        
        let author = Person(name: "User", photo: "picture")
        let repo = Repo(name: "RepoName", stars: 3, author: author)
        sut.repos = [repo]
        
        sut.updateList()
        
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertEqual(sut.refresh.isRefreshing, false)
        XCTAssertEqual(sut.refresh.attributedTitle?.string, "Puxe para atualizar")
    }
    
    func test_displayRepos_updatesList_whenFirstPage() {
        let author1 = Person(name: "User", photo: "picture")
        let repo1 = Repo(name: "RepoName", stars: 3, author: author1)
        sut.repos = [repo1]
        
        let author2 = Person(name: "User", photo: "picture")
        let repo2 = Repo(name: "RepoName", stars: 3, author: author2)
        sut.displayRepos([repo2], isFirstPage: true)
        
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertEqual(sut.repos.count, 1)
    }
    
    func test_displayRepos_appendResults_whenNotFirstPage() {
        let author1 = Person(name: "User", photo: "picture")
        let repo1 = Repo(name: "RepoName", stars: 3, author: author1)
        sut.repos = [repo1]
        
        let author2 = Person(name: "User", photo: "picture")
        let repo2 = Repo(name: "RepoName", stars: 3, author: author2)
        sut.displayRepos([repo2], isFirstPage: false)
        
        XCTAssertEqual(sut.isLoading, false)
        XCTAssertEqual(sut.repos.count, 2)
    }
}
