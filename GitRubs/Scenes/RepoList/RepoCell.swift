import UIKit

class RepoCell: UITableViewCell {
    static let identifier = "repoCell"

    let lblRepoName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 25)
        lbl.textColor = .black
        lbl.setCodable()
        return lbl
    }()

    let authorView: UIView = {
        let view = UIView()
        view.setCodable()
        view.clipsToBounds = true
        return view
    }()

    let imgAuthor: UIImageView = {
        let img = UIImageView()
        img.setCodable()
        img.image = UIImage(systemName: "person.crop.circle")
        img.tintColor = .black
        img.contentMode = .scaleAspectFill
        
        // Border
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.lightGray.cgColor
        img.layer.cornerRadius = 15
        img.clipsToBounds = true
        return img
    }()

    let lblAuthorName: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = .lightGray
        lbl.setCodable()
        return lbl
    }()

    let imgStar: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "star")
        img.tintColor = .black
        img.setCodable()
        img.contentMode = .scaleAspectFit
        return img
    }()

    let lblStars: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = .lightGray
        lbl.setCodable()
        return lbl
    }()

    func setupUI() {
        contentView.addSubview(lblRepoName)

        authorView.addSubview(imgAuthor)
        authorView.addSubview(lblAuthorName)
        contentView.addSubview(authorView)

        contentView.addSubview(imgStar)
        contentView.addSubview(lblStars)

        setupConstraints()
    }

    func setupConstraints() {
        // Repo Name
        lblRepoName.setTop(to: contentView.topAnchor, constant: 10)
        lblRepoName.setLeading(to: contentView.leadingAnchor, constant: 10)
        lblRepoName.setTrailing(to: imgStar.leadingAnchor, constant: 10)
        lblRepoName.setHeight(40)

        // Author View
        authorView.setTop(to: lblRepoName.bottomAnchor, constant: 10)
        authorView.setBottom(to: contentView.bottomAnchor, constant: 10)
        authorView.setLeading(to: contentView.leadingAnchor, constant: 10)
        authorView.setTrailing(to: lblStars.leadingAnchor, constant: 10)
        authorView.setHeight(30)
        // - Picture
        imgAuthor.setTop(to: authorView.topAnchor)
        imgAuthor.setBottom(to: authorView.bottomAnchor)
        imgAuthor.setLeading(to: authorView.leadingAnchor)
        imgAuthor.setWidth(30)
        // - Name
        lblAuthorName.setTop(to: authorView.topAnchor)
        lblAuthorName.setBottom(to: authorView.bottomAnchor)
        lblAuthorName.setTrailing(to: authorView.trailingAnchor)
        lblAuthorName.setLeading(to: imgAuthor.trailingAnchor, constant: 10)

        // Stars View
        // - Star
        imgStar.setTop(to: contentView.topAnchor, constant: 10)
        imgStar.setTrailing(to: contentView.trailingAnchor, constant: 10)
        imgStar.setHeight(40)
        // - Number
        lblStars.setTop(to: imgStar.bottomAnchor, constant: 10)
        lblStars.setBottom(to: contentView.bottomAnchor, constant: 10)
        lblStars.setTrailing(to: contentView.trailingAnchor, constant: 10)
    }

    func configure(repo: Repo) {
        lblRepoName.text = repo.name
        lblAuthorName.text = repo.author.name
        imgAuthor.setImage(url: repo.author.photo)
        lblStars.text = "\(repo.stars)"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
}
