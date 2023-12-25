//
//  TestDownloader.swift
//  Earthquakes
//
//  Created by luis armendariz on 12/24/23.
//

import Foundation


class TestDownloader: HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data {
        fatalError("unimplemented")
    }
}
