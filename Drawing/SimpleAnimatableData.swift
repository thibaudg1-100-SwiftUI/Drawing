//
//  SimpleAnimatableData.swift
//  Drawing
//
//  Created by RqwerKnot on 16/02/2022.
//

import SwiftUI

struct Trapezoid: Shape {
    var insetAmount: Double
    
    // this computed property handles Animatable Data that SwiftUI uses when using 'withAnimation'
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
   }
}

struct SimpleAnimatableData: View {
    
    @State private var insetAmount = 50.0
    
    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 300, height: 200)
            .onTapGesture {
                withAnimation { // won't animate if the View (here the custon Shape) is not handling Animatable data
                    insetAmount = Double.random(in: 10...135)
                }
            }
//            .animation(.default, value: insetAmount) // could also be used instead of withAnimation
    }
}

struct SimpleAnimatableData_Previews: PreviewProvider {
    static var previews: some View {
        SimpleAnimatableData()
    }
}
