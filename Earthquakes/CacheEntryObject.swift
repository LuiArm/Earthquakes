//
//  CacheEntryObject.swift
//  Earthquakes
//
//  Created by luis armendariz on 1/9/24.
//

import Foundation

//A Swift enumeration is a natural way to model this cache entry. NSCache is designed to hold reference types, but a Swift enumeration is a value type. a class will be created to hold the enumeration and insert an instance of this class into the cache.


//You can safely pass any instance of this object across threads because the 'final' declaration and the 'let' property make every instance immutable.

final class CacheEntryObject {
    let entry: CacheEntry
    init(entry: CacheEntry) { self.entry = entry }
}



enum CacheEntry {
    //the inProgress enumeration used to avoid making a second network request for a location that has been requested but not loaded.
    case inProgress(Task<QuakeLocation, Error>)
    case ready(QuakeLocation)
    
}
