//
//  Quake.swift
//  Earthquakes
//
//  Created by luis armendariz on 12/7/23.
//

import Foundation


struct Quake: Identifiable {
    var id: String { code }
    let magnitude: Double
    let place: String
    let time: Date
    let code: String
    let detail: URL
    var location: QuakeLocation?
}


//extension Quake:  {
//    var id: String { code }
//}

extension Quake: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        // JSON reads as "mag"
        case magnitude = "mag"
        case place
        case time
        case code
        case detail
    }
    
    init(from decoder: Decoder) throws {
        //keyed container provides methods that youo use to retrieve info from encoded data based on keys defined in enum above
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //If the decoder fails to create a keyed container, the initializer throws an error. If the container fails to decode a property, a nil value is assigned, and the initializer continues.
        let rawMagnitude = try? values.decode(Double.self, forKey: .magnitude)
        let rawPlace = try? values.decode(String.self, forKey: .place)
        let rawTime = try? values.decode(Date.self, forKey: .time)
        let rawCode = try? values.decode(String.self, forKey: .code)
        let rawDetail = try? values.decode(URL.self, forKey: .detail)
        
        //unwrap properties
        guard let magnitude = rawMagnitude,
              let place = rawPlace,
              let time = rawTime,
              let code = rawCode,
              let detail = rawDetail
        else {
            throw QuakeError.missingData
        }
        
        self.magnitude = magnitude
        self.place = place
        self.time = time
        self.code = code
        self.detail = detail
    }
}
