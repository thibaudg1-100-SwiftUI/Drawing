//
//  Arrows.swift
//  Drawing
//
//  Created by RqwerKnot on 21/02/2022.
//

import SwiftUI

struct Arrow1: Shape {
    func path(in rect: CGRect) -> Path {
        var path  = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.move(to: CGPoint(x: rect.maxX * 4 / 5, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.move(to: CGPoint(x: rect.maxX * 4 / 5, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
 
        return path
    }
}

struct Arrow2: Shape {
    
    var thickness: Double = 10
    
    // this computed property handles Animatable Data that SwiftUI uses when using 'withAnimation'
    var animatableData: Double {
        get { thickness }
        set { thickness = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path  = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.height / thickness))
        path.addLine(to: CGPoint(x: rect.maxX * 4 / 5, y: rect.height / thickness))
        path.addLine(to: CGPoint(x: rect.maxX * 4 / 5, y: rect.height / (thickness * 2 ) ))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX * 4 / 5, y: rect.height * (1 - 1 / (thickness * 2))))
        path.addLine(to: CGPoint(x: rect.maxX * 4 / 5, y: rect.height * (1 - 1 / thickness)))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.height * (1 - 1 / thickness)))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.height / thickness))
        path.closeSubpath()
 
        return path
    }
}

struct Arrows: View {
    
    @State private var thickness = 0.5
    @State private var arrow2thickness = 4.0
    
    var body: some View {
        
        VStack(spacing: 50) {
            
            Arrow1()
//                .fill(.yellow)
                .stroke(.mint, lineWidth: thickness * 20 + 1)
    //            .stroke(.purple, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
            .frame(width: 300, height: 200)
            .animation(.default.delay(0.75), value: thickness)
            
            
            Slider(value: $thickness)
                .padding()
            
            Arrow2(thickness: arrow2thickness)
                .fill(.yellow)
//                .stroke(.red, lineWidth: 5)
                .frame(width: 300, height: 200)
                .onTapGesture {
                    // spring animation when tapping the shape:
                    withAnimation(.interpolatingSpring(stiffness: 40, damping: 4)) {
                        if arrow2thickness > 4 { arrow2thickness = 3 } else { arrow2thickness = 6 }
                    }
                    
                }
            
            // different animation when using the Slider:
            Slider(value: $arrow2thickness.animation(.default.delay(2)), in: 2.005...10)
                .padding()
                
        }
    }
}

struct Arrows_Previews: PreviewProvider {
    static var previews: some View {
        Arrows()
    }
}
