//
//  EarthquakesTests.swift
//  EarthquakesTests
//
//  Created by luis armendariz on 12/11/23.
//

import XCTest
// gives access to all project objects
@testable import Earthquakes


final class EarthquakesTests: XCTestCase {

    func testGeoJSONDecodesQuake() throws {
        //creating JSON decoder
        let decoder = JSONDecoder()
        
        //By default, the JSON decoder decodes time as seconds and the expected results as milliseconds.
        decoder.dateDecodingStrategy = .millisecondsSince1970
        
        //making sure to decode the correct testFeature
        let quake = try decoder.decode(Quake.self, from: testFeature_nc73649170)
        
        //Geting the test data
        XCTAssertEqual(quake.code, "73649170")
        
        // expected seconds from data
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        
        // seconds actually calculated when decoded
        let decodedSeconds = quake.time.timeIntervalSince1970
        
        //checking if expectedSeconds and decodedSeconds match with an accuracy of hundreth thousands place.
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
        
    }
    
    func testGeoDecoderDecodesGeoJSON() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .millisecondsSince1970
        let decoded = try decoder.decode(GeoJSON.self, from: testQuakesData)
        
        XCTAssertEqual(decoded.quakes.count, 6)
        XCTAssertEqual(decoded.quakes[0].code, "73649170")
        
        let expectedSeconds = TimeInterval(1636129710550) / 1000
        let decodedSeconds = decoded.quakes[0].time.timeIntervalSince1970
        XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
    }
    
    func testQuakeDetailsDecoder() throws {
            let decoded = try JSONDecoder().decode(QuakeLocation.self, from: testDetail_hv72783692)
            XCTAssertEqual(decoded.latitude, 19.2189998626709, accuracy: 0.00000000001)
            XCTAssertEqual(decoded.longitude, -155.434173583984, accuracy: 0.00000000001)
        }

}
