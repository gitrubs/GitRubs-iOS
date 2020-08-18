import XCTest
@testable import GitRubs

class RepoCellTests: XCTestCase {
    var sut: RepoCell!
    
    override func setUp() {
        sut = RepoCell()
    }

    override func tearDown() {
        sut = nil
    }

    func test_setupUI_addsAllViews() {
        let subviews = sut.contentView.subviews
        XCTAssert(subviews.contains(sut.lblRepoName))
        XCTAssert(subviews.contains(sut.authorView))
        XCTAssert(subviews.contains(sut.imgStar))
        XCTAssert(subviews.contains(sut.lblStars))
        
        let authorSubviews = sut.authorView.subviews
        XCTAssert(authorSubviews.contains(sut.imgAuthor))
        XCTAssert(authorSubviews.contains(sut.lblAuthorName))
    }
    
    func test_configure_setsRightValues() {
        let author = Person(name: "User", photo: "picture")
        let repo = Repo(name: "RepoName", stars: 3, author: author)
        
        sut.configure(repo: repo)
        
        XCTAssertEqual(sut.lblRepoName.text, "RepoName")
        XCTAssertEqual(sut.lblAuthorName.text, "User")
        XCTAssertEqual(sut.lblStars.text, "3")
        
        // Placeholder image
        XCTAssertEqual(sut.imgAuthor.image, nil)
    }
}
