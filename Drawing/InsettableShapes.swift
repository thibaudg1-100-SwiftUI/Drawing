//
//  InsettableShapes.swift
//  Drawing
//
//  Created by RqwerKnot on 07/02/2022.
//

import SwiftUI

struct InsettableShapes: View {
    var body: some View {
        ScrollView {
            VStack{
                // creating 2 identical circles but one with a regular stroke:
                Circle()
                    .stroke(.blue, lineWidth: 40) // the outline is partly inside, partly outside of the original circle shape line
                    .frame(minHeight: 390)
                // we can see that the resulting shape overflows the screen area
                // another one with a different stroke that make use of insettable shapes:
                Circle()
                    .strokeBorder(.blue, lineWidth: 40)
                    .frame(minHeight: 390)
                // this time the originla Circle is adjusted so that its stroke outline remains inside its containers bounds
                
                // Now let's try the same with the Arc Shape we just created
                NaturalArc(startAngle: .degrees(-90), endAngle: .degrees(200), clockwise: true)
                    .stroke(.yellow, lineWidth: 40)
                    .frame(minHeight: 390)
                // Again it overflows the containers bounds as expected
                // Let's try to apply '.strokeBorder' instead:
                NaturalArc(startAngle: .degrees(-90), endAngle: .degrees(200), clockwise: true)
//                    .strokeBorder(.red, lineWidth: 40) // will trigger an error because NaturalArc has no member 'strokeBorder'
                    .frame(minHeight: 390)
                // this is because our custom Shape NaturalArc() does not conform to the necessary InsettableShape Protocol, as opposite to built-in Circle() Shape
                
                // Let's try again with an InsettableNaturalArc:
                InsettableNaturalArc(startAngle: .degrees(-90), endAngle: .degrees(210), clockwise: true)
                    .strokeBorder(.red, lineWidth: 40) // this time it works well
                    .frame(minHeight: 390)
                   
            }
        }
        
    }
}

struct InsettableShapes_Previews: PreviewProvider {
    static var previews: some View {
        InsettableShapes()
    }
}

// an Arc Shape that conforms to InsettableShape protocol:
// This protocol builds upon, hence conforms to Shape protocol: no need to add conformance to it below
struct InsettableNaturalArc: InsettableShape {

    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    
    var insetAmount = 0.0 // need an inset amount that can be changed so that insetting can be applied multiple times
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStartAngle = startAngle - rotationAdjustment
        let modifiedEndAngle = endAngle - rotationAdjustment
        
        var path = Path()
        // to reflect the inset value equally, let's edit the radius accordingly:
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.height / 2 - insetAmount, startAngle: modifiedStartAngle, endAngle: modifiedEndAngle, clockwise: !clockwise)

        return path
    }
    
    // inset function required for protocol conformance
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self // locally recreate the instance of InsettableNaturalArc that inset func was called on
        arc.insetAmount += amount // add a new inset
        return arc // return a new object InsettableNaturalArc with proper dimensions
    }
 
}

