//
//  Shapes.swift
//  Drawing
//
//  Created by RqwerKnot on 07/02/2022.
//

import SwiftUI

// define a shape using the Shape protocol that require to use a path
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

// we can design any custom shape, let's do an arc
// first a SwiftUI standard arc: X is horizontal axis from left to right of the container
// Y is vertical axis top to bottom of the container
struct TrigonometricArc: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.height / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)

        return path
    }
}

// a more natural arc starting from noon (12 o'clock) and turning clockwise
struct NaturalArc: Shape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStartAngle = startAngle - rotationAdjustment
        let modifiedEndAngle = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.height / 2, startAngle: modifiedStartAngle, endAngle: modifiedEndAngle, clockwise: !clockwise)

        return path
    }
 
}


// Make use of Shapes for reusability
struct Shapes: View {
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Triangle()
                    .fill(.mint)
                    .frame(width: 100, height: 100)
                
                Spacer()
                
                Triangle()
                    .stroke(.yellow, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .frame(width: 100, height: 100)
            }
            .padding(.horizontal)
            
            TrigonometricArc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: false)
                .stroke(.blue, lineWidth: 5)
            
            NaturalArc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
                .stroke(.blue, lineWidth: 5)
        }
        .padding(.horizontal)
    }
}

struct Shapes_Previews: PreviewProvider {
    static var previews: some View {
        Shapes()
    }
}
