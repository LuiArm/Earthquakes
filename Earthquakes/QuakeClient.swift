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
            var updatedQuakes = allQuakes.quakes
            if let olderThanOneHour = updatedQuakes.firstIndex(where: { $0.time.timeIntervalSinceNow > 3600}) {
                let indexRange = updatedQuakes.startIndex..<olderThanOneHour
                try await withThrowingTaskGroup(of: (Int, QuakeLocation).self) { group in
                    for index in indexRange {
                        group.addTask {
                            let location = try await self.quakeLocation(from: allQuakes.quakes[index].detail)
                            return (index, location)
                        }
                    }
                    while let result = await group.nextResult() {
                        switch result {
                        case .failure(let error):
                            throw error
                        case .success(let (index, location)):
                            updatedQuakes[index].location = location
                        }
                    }
                }
            }
            return updatedQuakes
        }
    }
    
    
    // property for JSON decoder, using anonymous closure to initialize the property lets you change the date decoding strategy. Lazy will create decoder until its needed
    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .millisecondsSince1970
        return aDecoder
    }()
    
    //add httpdownloader property
    let downloader: any HTTPDataDownloader
    
    //initializer to set the property value
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
    // url for feed
    private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!
    
    
    // helper func to get quakes 
    func quakeLocation(from url: URL) async throws -> QuakeLocation {
        //Waiting on an in-progress task here avoids making a second network request
        if let cached = quakeCache[url] {
            switch cached {
            case .ready(let location):
                return location
            case .inProgress(let task):
                return try await task.value
            }
        }
        
        //Task to fetch locations, task allows to store the task and check its progress later
        let task = Task<QuakeLocation, Error> {
            let data = try await downloader.httpData(from: url)
            let location = try decoder.decode(QuakeLocation.self, from: data)
            return location
        }
        //store task in the cache and await the result
        quakeCache[url] = .inProgress(task)
        
        do {
            let location = try await task.value
            //store final quake location in the cache and return location
            quakeCache[url] = .ready(location)
            return location
        }catch {
            quakeCache[url] = nil
            throw error
        }
        
    }
    
}
