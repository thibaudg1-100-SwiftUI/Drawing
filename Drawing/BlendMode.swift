//
//  SpecialEffects.swift
//  Drawing
//
//  Created by RqwerKnot on 16/02/2022.
//

import SwiftUI

struct BlendMode: View {
    var body: some View {
        VStack {
            // one of the Blend Mode setting is 'multiply'
            // it multiplies 2 views piwels together
            ZStack {
                Image("PaulHudson")

                Rectangle()
                    .fill(.red)
                    .blendMode(.multiply)
            }
            .frame(width: 350, height: 300)
            .clipped()
            
            // this effect is so common  that it can be applied directly to an Image
            // avoiding usin a ZStack
            Image("PaulHudson")
                .colorMultiply(.red)
                .frame(width: 350, height: 300)
                .clipped()
        }
    }
}

struct BlendMode_Previews: PreviewProvider {
    static var previews: some View {
        BlendMode()
    }
}
