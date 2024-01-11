//
//  QuakeClient.swift
//  Earthquakes
//
//  Created by luis armendariz on 12/20/23.
//

import Foundation

//actor designation protects the cache from simultaneous access from multiple threads
actor QuakeClient {
    //Because the NSCache generic parameters are the same as the extension constraints, you can use the subscript to access the contents of the cache.
    private let quakeCache: NSCache<NSString, CacheEntryObject> = NSCache()
    
    //computed, asynchronous, throwing property to fetch the earthquakes
    var quakes: [Quake] {
        //Making a property asynchronous or throwing requires the explicit get syntax for a computed property.
        get async throws {
            let data = try await downloader.httpData(from: feedURL)
            let allQuakes = try decoder.decode(GeoJSON.self, from: data)
            return allQuakes.quakes
        }
    }
    
    
    // property for JSON decoder, using anonymous closure to initialize the property lets you change the date decoding strategy. Lazy will create decoder until its needed
    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .millisecondsSince1970
        return aDecoder
    }()
    
    //add downloader property
    let downloader: any HTTPDataDownloader
    
    //initializer to set the property value
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
    // url for feed
    private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
    
    
    //
    func quakeLocation(from url: URL) async throws -> QuakeLocation {
        //Task to fetch locations, task allows to store the task and check its progress later
        let task = Task<QuakeLocation, Error> {
            let data = try await downloader.httpData(from: url)
            let location = try decoder.decode(QuakeLocation.self, from: data)
            return location
        }
        //store task in the cache and await the result
        quakeCache[url] = .inProgress(task)
        let location = try await task.value
        //store final quake location in the cache and return location
        quakeCache[url] = .ready(location)
        return location
    }
    
}
