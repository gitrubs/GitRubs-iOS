import UIKit
import Kingfisher

extension UIImageView {
    func setImage(url path: String) {
        let url = URL(string: path)
        kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "person.circle.crop"),
            options: [
                .transition(.fade(1))
            ])
    }
}
