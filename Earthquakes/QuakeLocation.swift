//
//  QuakeLocation.swift
//  Earthquakes
//
//  Created by luis armendariz on 12/15/23.
//

//The GeoJSON object’s location information is embedded inside a deeply nested structure. To decode the location information, you’ll create Swift structures that reflect the complex nesting hierarchy of the input data.


import Foundation

struct QuakeLocation {
    var latitude: Double {properties.products.origin.first!.properties.latitude}
    var longitude: Double { properties.products.origin.first!.properties.longitude}
    // var to store roo of geojson hierarchy
    private var properties: RootProperties
    
    
    struct RootProperties: Decodable {
        var products: Products
    }
    
    struct Products: Decodable {
        var origin: [Origin]
    }
    
    struct Origin: Decodable {
        var properties: OriginProperties
    }
    
    struct OriginProperties {
        var latitude: Double
        var longitude: Double
    }
}


extension QuakeLocation.OriginProperties: Decodable {
    private enum OriginPropertiesCodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OriginPropertiesCodingKeys.self)
        let longitude = try container.decode(String.self, forKey: .longitude)
        let latitude = try container.decode(String.self, forKey: .latitude)
        guard let longitude = Double(longitude), let latitude = Double(latitude) else { throw QuakeError.missingData}
        self.latitude = latitude
        self.longitude = longitude
    }
}
