//
//  Paths.swift
//  Drawing
//
//  Created by RqwerKnot on 07/02/2022.
//

import SwiftUI

struct Paths: View {
    var body: some View {
        VStack{
            // creating a path by giving a closure that take an initial empty path as parameter:
            Path { path in
                // coordinates have to be passed to create a path,
                // which can be an issue for device compatibility
                
                path.move(to: CGPoint(x: 200, y: 100)) // move to the staring point of the path
                path.addLine(to: CGPoint(x: 100, y: 300)) // add a line from current path position to the point passed as argument
                path.addLine(to: CGPoint(x: 300, y: 300))
                path.addLine(to: CGPoint(x: 200, y: 100))
            }
            .fill(.yellow) // fill the shape defined by the described path
            
            HStack {
                Path { path in
                    path.move(to: CGPoint(x: 100, y: 100)) // move to the staring point of the path
                    path.addLine(to: CGPoint(x: 50, y: 200)) // add a line from current path position to the point passed as argument
                    path.addLine(to: CGPoint(x: 150, y: 200))
                    path.addLine(to: CGPoint(x: 100, y: 100))
                }
                .stroke(.mint, lineWidth: 12)
                // the outline is not well formed at the top angle of the triangle because the first line and last line are not implicitly connected by SwiftUI

                // one way to fix it is to close the subpath = the shape we’ve drawn inside our path:
                Path { path in
                    path.move(to: CGPoint(x: 100, y: 100)) // move to the staring point of the path
                    path.addLine(to: CGPoint(x: 50, y: 200)) // add a line from current path position to the point passed as argument
                    path.addLine(to: CGPoint(x: 150, y: 200))
                    path.addLine(to: CGPoint(x: 100, y: 100))
                    path.closeSubpath()
                }
                .stroke(.red, lineWidth: 12)
            }
            
            // another way to fix the misformed outline is to use a specific StrokeStyle that let us define line joins and line caps shape:
            Path { path in
                path.move(to: CGPoint(x: 200, y: 50))
                path.addLine(to: CGPoint(x: 100, y: 200))
                path.addLine(to: CGPoint(x: 300, y: 200))
                path.addLine(to: CGPoint(x: 200, y: 50))
            }
            .stroke(.purple, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        }
    }
}

struct Paths_Previews: PreviewProvider {
    static var previews: some View {
        Paths()
    }
}
