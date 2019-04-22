import SnapKit
import UIKit

extension UIViewController {
    
    var safeAreaBottom: ConstraintItem {
        if #available(iOS 11, *) {
            return self.view.safeAreaLayoutGuide.snp.bottom
        } else {
            return self.view.snp.bottom
        }
    }
    var safeAreaTop: ConstraintItem {
        if #available(iOS 11, *) {
            return self.view.safeAreaLayoutGuide.snp.top
        } else {
            return self.view.snp.top
        }
    }
}
