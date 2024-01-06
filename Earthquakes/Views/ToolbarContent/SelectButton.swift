//
//  SelectButton.swift
//  Earthquakes
//
//  Created by luis armendariz on 1/4/24.
//

import SwiftUI

enum SelectMode {
    case active, inactive

    var isActive: Bool {
        self == .active
    }

    mutating func toggle() {
        switch self {
        case .active:
            self = .inactive
        case .inactive:
            self = .active
        }
    }
}

struct SelectButton: View {
    @Binding var mode: SelectMode
    var action: () -> Void = {}
    var body: some View {
        Button {
            withAnimation {
                mode.toggle()
                action()
            }
        } label: {
            Text(mode.isActive ? "Deselect All" : "Select All")
        }
    }
}

//#Preview {
//    SelectButton(mode: <#Binding<SelectMode>#>)
//}
