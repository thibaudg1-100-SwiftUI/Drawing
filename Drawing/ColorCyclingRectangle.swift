//
//  ColorCyclingRectangle.swift
//  Drawing
//
//  Created by RqwerKnot on 21/02/2022.
//

import SwiftUI

struct CCR: View {
    var amount = 0.0
    
    var startPoint: UnitPoint = .top
    var endPoint: UnitPoint = .bottom
    
    let steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(LinearGradient( // using a Gradient is much more ressources expensive
                        gradient: Gradient(colors: [
                            color(for: value, brightness: 1),
                            color(for: value, brightness: 0.33)
                        ]),
                        startPoint: startPoint,
                        endPoint: endPoint
                                                ), lineWidth: 2)
            }
        }
        .drawingGroup() // Metal API enabled
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangle: View {
    
    @State private var amount = 0.0
    
    var startPosition: UnitPoint {
        UnitPoint(x: startX, y: startY)
    }
    var endPosition: UnitPoint {
        UnitPoint(x: endX, y: endY)
    }
    
    @State private var startX = 0.0
    @State private var startY = 0.0  
    @State private var endX = 1.0
    @State private var endY = 1.0
    
    var body: some View {
        
        VStack(spacing: 20) {
            CCR(amount: amount, startPoint: startPosition, endPoint: endPosition)
                .frame(width: 300, height: 300)
            
            VStack(alignment: .leading) {
                Text("Hue shifting:")
                Slider(value: $amount)
                    .padding([.horizontal, .bottom])
                
                Text("Linear gradient start position X:")
                Slider(value: $startX)
                    .padding(.horizontal)
                Text("Linear gradient start position Y:")
                Slider(value: $startY)
                    .padding([.horizontal, .bottom])
                
                Text("Linear gradient end position X:")
                Slider(value: $endX)
                    .padding(.horizontal)
                Text("Linear gradient end position Y:")
                Slider(value: $endY)
                    .padding(.horizontal)
            }
           
            
        }
        
        
        
    }
}

struct ColorCyclingRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangle()
    }
}
