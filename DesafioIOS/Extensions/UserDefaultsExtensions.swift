//
//  UserDefaultsExtensions.swift
//  DesafioIOS
//
//

import Foundation

// https://www.swiftbysundell.com/articles/property-wrappers-in-swift/
@propertyWrapper
struct UserDefaultsWrapper<Value>{
    let key : String
    let defaultValue : Value
    let container : UserDefaults
    
    var wrappedValue : Value{
        get{
            let value = container.value(forKey: key) as? Value ?? defaultValue
            return value
        }set{
            if let optional = newValue as? AnyOptional, optional.isNil{
                container.removeObject(forKey: key)
            }else{
                container.setValue(newValue, forKey: key)
            }
        }
    }
    
    init(key : String, defaultValue: Value, container: UserDefaults = UserDefaults.standard){
        self.key = key
        self.defaultValue = defaultValue
        self.container = container
    }
}

extension UserDefaultsWrapper where Value : ExpressibleByNilLiteral{
    init(key : String){
        self.init(key: key, defaultValue: nil)
    }
}

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}
