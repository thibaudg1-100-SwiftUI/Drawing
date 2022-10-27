//
//  BlendMode2.swift
//  Drawing
//
//  Created by RqwerKnot on 16/02/2022.
//

import SwiftUI

struct BlendMode2: View {
    @State private var amount = 0.5

        var body: some View {
            // .screen BlendMode does the opposite of .multiply by producing brighter results in the rendered view
            VStack {
                ZStack {
                    Circle()
//                        .fill(.red) // Color.red is not a pure red but an adaptative SwiftUI color that looks great in light and dark mode and in most contexts
                        .fill(Color(red: 1, green: 0, blue: 0)) // this is pure RGB red
                        .frame(width: 200 * amount)
                        .offset(x: -50, y: -80)
                        .blendMode(.screen)

                    Circle()
//                        .fill(.green)
                        .fill(Color(red: 0, green: 1, blue: 0))
                        .frame(width: 200 * amount)
                        .offset(x: 50, y: -80)
                        .blendMode(.screen)

                    Circle()
//                        .fill(.blue)
                        .fill(Color(red: 0, green: 0, blue: 1))
                        .frame(width: 200 * amount)
                        .blendMode(.screen)
                }
                .frame(width: 300, height: 300)

                Slider(value: $amount)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
        }
}

struct BlendMode2_Previews: PreviewProvider {
    static var previews: some View {
        BlendMode2()
    }
}
