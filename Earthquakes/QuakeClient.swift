//
//  QuakeClient.swift
//  Earthquakes
//
//  Created by luis armendariz on 12/20/23.
//

import Foundation

class QuakeClient {
    
    // property for JSON decoder, using anonymous closure to initialize the property lets you change the date decoding strategy. Lazy will create decoder until its needed
    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        aDecoder.dateDecodingStrategy = .millisecondsSince1970
        return aDecoder
    }()
    
    
    
    // url for feed
    private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")
}
