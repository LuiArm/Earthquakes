//
//  QuakesProvider.swift
//  Earthquakes
//
//  Created by luis armendariz on 12/26/23.
//

import Foundation

//Marking the whole class with @MainActor makes methods of this class execute on the main thread.
@MainActor
class QuakesProvider: ObservableObject {
    //array of quakes will be published
    @Published var quakes: [Quake] = []
    
    let client: QuakeClient
    
    //loads quakes from QuakeClient and updates the published array
    func fetchQuakes() async throws {
        let latestQuakes = try await client.quakes
        self.quakes = latestQuakes
    }
    
    //deletes elements from the published array
    func deletQuakes(atOffse offSets: IndexSet) {
    //This function takes an IndexSet parameter to match the parameters of the onDelete(perform:) modifier of List.
        quakes.remove(atOffsets: offSets)
    }
    
    //initiate a default QuakeClient instance, default QuakeClient uses URLSession
    init(client: QuakeClient = QuakeClient()) {
        self.client = client
    }
}
