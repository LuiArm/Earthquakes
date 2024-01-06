//
//  QuakeMagnitude.swift
//  Earthquakes
//
//  Created by luis armendariz on 1/1/24.
//

import SwiftUI

struct QuakeMagnitude: View {
    var quake: Quake

    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(.black)
            .frame(width: 80, height: 60)
            .overlay {
                Text("\(quake.magnitude.formatted(.number.precision(.fractionLength(1))))")
                    .font(.title)
                    .bold()
                    .foregroundStyle(quake.color)
            }
    }

}

//#Preview {
//    QuakeMagnitude()
//}
