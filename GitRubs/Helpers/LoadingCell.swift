import UIKit

class LoadingCell: UITableViewCell {
    static let identifier = "loadingCell"

    let spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.color = .black
        view.style = .large
        view.setCodable()
        return view
    }()

    let lblLoading: UILabel = {
        let lbl = UILabel()
        lbl.setCodable()
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.text = "Carregando repositórios..."
        return lbl
    }()

    func setupUI() {
        contentView.addSubview(spinner)
        contentView.addSubview(lblLoading)
        setupConstraints()
    }

    func setupConstraints() {
        // Spinner
        spinner.setTop(to: contentView.topAnchor, constant: 20)
        spinner.setCenterX(to: contentView.centerXAnchor)
        spinner.setSize(height: 30, width: 30)

        // Label
        lblLoading.setTop(to: spinner.bottomAnchor, constant: 10)
        lblLoading.setCenterX(to: contentView.centerXAnchor)
        lblLoading.setBottom(to: contentView.bottomAnchor, constant: 10)
        lblLoading.setHeight(20)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
