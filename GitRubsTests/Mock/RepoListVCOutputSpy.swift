@testable import GitRubs

class RepoListVCOutputSpy: RepoListVCOutput {
    @Spy var invokedAskForRepos: Bool?
    @Spy var invokedAskForNextPage: Bool?
    
    func askForRepos() {
        invokedAskForRepos = true
    }
    
    func askForNextPage() {
        invokedAskForNextPage = true
    }
}
