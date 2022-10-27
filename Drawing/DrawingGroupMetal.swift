//
//  DrawingGroupMetal.swift
//  Drawing
//
//  Created by RqwerKnot on 11/02/2022.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(color(for: value, brightness: 1), lineWidth: 2)
            }
        }
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct GradientColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100
    var drawingGroupEnabled = false
    
    var body: some View {
        if drawingGroupEnabled {
            ZStack {
                ForEach(0..<steps) { value in
                    Circle()
                        .inset(by: Double(value))
                        .strokeBorder(LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.2)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ), lineWidth: 2)
                }
            }
            .drawingGroup() // use this modifier to make use of Metal API for the rendering
        } else {
            ZStack {
                ForEach(0..<steps) { value in
                    Circle()
                        .inset(by: Double(value))
                        .strokeBorder(LinearGradient( // using a Gradient is much more ressources expensive
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.2)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ), lineWidth: 2)
                }
            }
        }
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct DrawingGroupMetal: View {
    
    @State private var colorCycle = 0.0
    @State private var metalOn = false
    
    var body: some View {
        VStack{
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            GradientColorCyclingCircle(amount: colorCycle, drawingGroupEnabled: metalOn)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)
            
            Toggle("Activate Metal", isOn: $metalOn)
        }
        .padding()
    }
}

struct DrawingGroupMetal_Previews: PreviewProvider {
    static var previews: some View {
        DrawingGroupMetal()
    }
}
