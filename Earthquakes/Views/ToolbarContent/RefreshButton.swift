//
//  RefreshButton.swift
//  Earthquakes
//
//  Created by luis armendariz on 1/4/24.
//

import SwiftUI

struct RefreshButton: View {
    var action: () -> Void = {}
    var body: some View {
        Button(action: action) {
            Label("Refresh", systemImage: "arrow.clockwise")
        }
    }
}

#Preview {
    RefreshButton()
}
