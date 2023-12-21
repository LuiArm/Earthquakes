//
//  HTTPDataDownloader.swift
//  Earthquakes
//
//  Created by luis armendariz on 12/17/23.
//

import Foundation

let validStatus = 200...299

//Defining this protocol abstracts the network transport from the rest of the client code. This abstraction lets you use a testable structure in place of a network client
protocol HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        guard let (data, response) = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw QuakeError.networkError
        }
        return data 
    }
}
