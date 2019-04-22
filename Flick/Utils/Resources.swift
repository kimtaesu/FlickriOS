import Foundation

enum Status {
    case success
    case error
}

protocol ResourcesType {
    associatedtype RESULT
    
    var status: Status { get }
    var error: Error? { get }
    var data: RESULT? { get }
}

extension ResourcesType {
    func unwrap(do successCallback: @escaping (RESULT) -> Void, error errorCallback: @escaping (Error) -> Void) {
        if let error = self.error {
            errorCallback(error)
        }
        if let data = self.data {
            successCallback(data)
        }
    }
}

struct Resources<T>: ResourcesType {
    var status: Status
    var error: Error?
    var data: T?
}

extension Resources {
    static func success(_ data: T?) -> Resources<T> {
        return Resources(status: .success, error: nil, data: data)
    }
    static func error(_ error: Error?) -> Resources<T> {
        return Resources(status: .error, error: error, data: nil)
    }
}
