//
//  SaturationBlur.swift
//  Drawing
//
//  Created by RqwerKnot on 16/02/2022.
//

import SwiftUI

struct SaturationBlur: View {
    
    @State private var amount = 0.0
    
    var body: some View {
        
        VStack {
            
            Image("PaulHudson")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .saturation(amount) // saturation (0 to 1) tells how much color is used in the Image going from 0: full grayscale to 1: full color
                .blur(radius: (1 - amount) * 20)
            
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
    }
}

struct SaturationBlur_Previews: PreviewProvider {
    static var previews: some View {
        SaturationBlur()
    }
}
