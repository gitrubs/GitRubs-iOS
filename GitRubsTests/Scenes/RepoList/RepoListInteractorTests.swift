import XCTest
@testable import GitRubs

class RepoListInteractorTests: XCTestCase {
    var sut: RepoListInteractor!
    var output: RepoListInteractorOutputSpy!
    var worker: MockRepoWorker!

    override func setUp() {
        sut = RepoListInteractor()
        
        worker = MockRepoWorker()
        sut.worker = worker

        output = RepoListInteractorOutputSpy()
        sut.output = output
    }
    
    func test_fetchRepos_callsWorker_withPage1() {
        sut.fetchRepos()
        
        XCTAssertEqual(worker.$invokedGetReposPage.value, 1)
        XCTAssertEqual(sut.currentPage, 1)
    }
    
    func test_fetchNextPage_callsWorker_withRightPage() {
        sut.currentPage = 2
        sut.fetchNextPage()
        
        XCTAssertEqual(worker.$invokedGetReposPage.value, 3)
        XCTAssertEqual(sut.currentPage, 3)
    }
    
    func test_fetchRepos_callsPresenteRepos_onSuccess() {
        worker.shouldFail = false
        worker.mockResponse = []
        
        sut.fetchRepos()

        XCTAssertEqual(output.$invokedPresentRepos.value?.repos.count, 0)
        XCTAssertEqual(output.$invokedPresentRepos.value?.page, 1)
        XCTAssertNil(output.$invokedPresentError.value)
    }
    
    func test_fetchRepos_callsPresenteError_onFail() {
        worker.shouldFail = true
        worker.mockError = "Bad error"
        
        sut.fetchRepos()

        XCTAssertNil(output.$invokedPresentRepos.value)
        XCTAssertEqual(output.$invokedPresentError.value, "Bad error")
    }
}
