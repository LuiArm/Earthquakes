//
//  QuakeClient.swift
//  Earthquakes
//
//  Created by luis armendariz on 12/20/23.
//

import Foundation

class QuakeClient {
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
}
