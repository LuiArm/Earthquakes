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

}
