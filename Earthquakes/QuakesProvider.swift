//
//  QuakesProvider.swift
//  Earthquakes
//
//  Created by luis armendariz on 12/26/23.
//

import Foundation


class QuakesProvider: ObservableObject {
    //array of quakes will be published
    @Published var quakes: [Quake] = []
}
