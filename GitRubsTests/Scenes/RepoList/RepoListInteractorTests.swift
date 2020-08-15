import XCTest
@testable import GitRubs

class RepoListInteractorTests: XCTestCase {
    var sut: RepoListInteractor!
    var output: RepoListInteractorOutputSpy!
    var worker: MockRepoWorker!

    override func setUp() {
        sut = RepoListInteractor()
        sut.worker = worker

        output = RepoListInteractorOutputSpy()
        sut.output = output
    }
}
