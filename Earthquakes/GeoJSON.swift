//
//  GeoJSON.swift
//  Earthquakes
//
//  Created by luis armendariz on 12/13/23.
//

import Foundation


struct GeoJSON: Decodable{
    
    //RootCodingKeys enum to tell the decoder which keys of the GeoJSON root object to decode. root object has four keys,  only need the value from the features key.
    private enum RootCodingKeys: String, CodingKey {
        case features
    }
    
    private enum FeatureCodingKeys: String, CodingKey {
        case properties
    }
    
    //using private(set) means code within this struct can modify the quakes property, but code outside the structure can only read the property value.
    private(set) var quakes: [Quake] = []
    
    
    init(from decoder: Decoder) throws {
        //get keyed container by using the root coding keys
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        
        //Get an unkeyed container using the features case of the root coding keys enumeration.
        var featureContainer = try rootContainer.nestedUnkeyedContainer(forKey: .features) //The features container lets you extract quakes, one at a time. The decoder accesses the elements chronologically.
        
        
        //Loop through the features container until the isAtEnd flag is true, and try to decode each element as a Quake. If successful, add the quake to the quakes array.
        while !featureContainer.isAtEnd {
            let propertiesContainer = try featureContainer.nestedContainer(keyedBy: FeatureCodingKeys.self)
            
            if let properties = try? propertiesContainer.decode(Quake.self, forKey: .properties) {
                quakes.append(properties) //Using try? ignores quakes with missing data. If the structure of the GeoJSON data is incorrect, however, the initializer throws an error.
            }
        }
    }
}
