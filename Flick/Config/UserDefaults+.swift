import Foundation
import UIKit

enum UserDefaultKeys: String {
 case resolution
}
extension UserDefaults {
    func value<T>(forKey key: UserDefaultKeys) -> T? {
        return UserDefaults.standard.value(forKey: key.rawValue) as? T
    }
    
    func set<T>(value: T?, forKey key: UserDefaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
}
