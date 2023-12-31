//
//  TestDownloader.swift
//  Earthquakes
//
//  Created by luis armendariz on 12/24/23.
//

import Foundation


class TestDownloader: HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data {
        //The call to Task.sleep(nanoseconds:) simulates network delay by sleeping for some amount of time.
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return testQuakesData
    }
}
