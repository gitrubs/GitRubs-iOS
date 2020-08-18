import XCTest
@testable import GitRubs

class RepoListPresenterTests: XCTestCase {
    var sut: RepoListPresenter!
    var output: RepoListPresenterOutputSpy!

    override func setUp() {
        sut = RepoListPresenter()
        output = RepoListPresenterOutputSpy()
        sut.output = output
    }
    
    func test_fetchRepos_callsShowReposOutput() {
        let repos = [
            Repo(
                name: "TestRepo",
                stars: 2,
                author: Person(
                    name: "Person",
                    photo: "picture"))]
        
        sut.formatRepos(repos, page: 1)

    XCTAssertEqual(output.$invokedShowRepos.value?.repos.count, 1)
        XCTAssertEqual(output.$invokedShowRepos.value?.repos[0].name, repos[0].name)
        XCTAssertEqual(output.$invokedShowRepos.value?.isFirstPage, true)
        XCTAssertNil(output.$invokedShowAlert.value)
    }
    
    func test_formatError_callsShowAlertOutput() {
        sut.formatError("Message")

        XCTAssertEqual(output.$invokedShowAlert.value?.title, "Eita!")
        XCTAssertEqual(output.$invokedShowAlert.value?.message, "Message")
    }
}
