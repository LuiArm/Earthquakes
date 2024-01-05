//
//  DeleteButton.swift
//  Earthquakes
//
//  Created by luis armendariz on 1/4/24.
//

import SwiftUI

struct DeleteButton: View {
    var action: () -> Void = {}
    var body: some View {
        Button(action: action) {
            Label("Delete", systemImage: "trash")
        }
    }
}

#Preview {
    DeleteButton()
}
