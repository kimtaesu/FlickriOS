import Foundation
import UIKit

enum UserDefaultKeys: String {
    case resolution
    case photoStride
}
extension UserDefaults {
    func value<T>(forKey key: UserDefaultKeys) -> T {
        // swiftlint:disable force_cast
        return UserDefaults.standard.value(forKey: key.rawValue) as! T
    }

    func set<T>(value: T?, forKey key: UserDefaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    func userDefaultRegister() {
        UserDefaults.standard.register(defaults: [UserDefaultKeys.photoStride.rawValue: Enviroment.DEFAULT_PER_PAGE])
    }
}
