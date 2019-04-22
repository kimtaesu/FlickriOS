import UIKit

extension UILabel {
    func setTextSize(_ size: CGFloat) {
        self.font = self.font.withSize(size)
    }
}

extension UIButton {
    func setTextSize(_ size: CGFloat) {
        self.titleLabel?.setTextSize(size)
    }
}
