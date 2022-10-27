//
//  ImagePainting.swift
//  Drawing
//
//  Created by RqwerKnot on 11/02/2022.
//

import SwiftUI

struct ImagePainting: View {
    var body: some View {
        
        ScrollView {
            VStack {
                // We can use an Image as a Background because Image conforms to View as is required by .background
                Text("Hello World")
                    .frame(width: 300, height: 300)
                    .background(Image("image3"), alignment: .topLeading)
                    .clipped()
                
                // But we can't use Image as a Border because Image does not conform to ShapeStyle protocol as is required by .border
                Text("Hello World")
                //                .frame(width: 300, height: 300)
                //                .border(Image("image3"), width: 5)
                
                // We can fix that by using ImagePaint that adopts ShapeStyle protocol and renders part of an Image
                Text("Hello World")
                    .frame(width: 300, height: 300)
                    .border(ImagePaint(image: Image("image3")), width: 30)
                
                Text("Hello World")
                    .frame(width: 300, height: 300)
                    .border(ImagePaint(image: Image("image3"), scale: 0.4), width: 100)
                
                Text("Hello World")
                    .frame(width: 300, height: 300)
                    .border(ImagePaint(image: Image("image3"), sourceRect: CGRect(x: 0.2, y: 0.2, width: 0.3, height: 0.5), scale: 0.7), width: 50)
                
                Capsule()
                    .strokeBorder(ImagePaint(image: Image("image3"), scale: 0.1), lineWidth: 20)
                    .frame(width: 300, height: 200)
                    
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct ImagePainting_Previews: PreviewProvider {
    static var previews: some View {
        ImagePainting()
    }
}
