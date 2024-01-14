//
//  NSCache+Subscript.swift
//  Earthquakes
//
//  Created by luis armendariz on 1/10/24.
//

import Foundation


//constraining the extension to NSCache types,The code added to the extension applies only to instances of NSCache with a matching key and object type.
extension NSCache where KeyType == NSString, ObjectType == CacheEntryObject{
   //Defining subscripts lets you read and write to the cache with a notation similar to Dictionary.
    subscript(_ url: URL) -> CacheEntry? {
        //getter that retrieves a CacheEntryObject from the cache and returns the CacheEntry
        get {
            //Because of the generic constraint on the NSCache extension, the method object(forKey:) takes an NSString and returns an optional CacheEntryObject
            let key = url.absoluteString as NSString
            let value = object(forKey: key)
            return value?.entry
        }
        //setter to store CacheEntryObject
        set{
            //Inside the setter, the compiler synthesizes a newValue variable that you can use to access the incoming value.
            let key = url.absoluteString as NSString
            if let entry = newValue {
                let value = CacheEntryObject(entry: entry)
                setValue(value, forKey: key as String)
            } else { // If the new value is nil, remove the object from the cache.
                removeObject(forKey: key)
                //This behavior of removing an object when nil is assigned mirrors the behavior of Dictionary
            }
        }
    }
    
}
