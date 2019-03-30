protocol DictionarySerializable {
    var properties: [String] { get }
    
    func valueForKey(key: String) -> Any?
    func toDictionary() -> [String: Any]
}

extension DictionarySerializable {
    func toDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        
        for prop in self.properties {
            if let val = self.valueForKey(key: prop) as? String {
                dict[prop] = val
            } else if let val = self.valueForKey(key: prop) as? Int {
                dict[prop] = val
            } else if let val = self.valueForKey(key: prop) as? Double {
                dict[prop] = val
            } else if let val = self.valueForKey(key: prop) as? [String] {
                dict[prop] = val
            } else if let val = self.valueForKey(key: prop) as? DictionarySerializable {
                dict[prop] = val.toDictionary()
            } else if let val = self.valueForKey(key: prop) as? [DictionarySerializable] {
                var arr = [[String: Any]]()
                
                for item in (val as [DictionarySerializable]) {
                    arr.append(item.toDictionary())
                }
                
                dict[prop] = arr
            }
        }
        
        return dict
    }
}
