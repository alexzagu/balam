//
//  SwiperView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 30/07/2021.
//

import SwiftUI

struct SwiperView<Element>: View where Element: View, Element: Identifiable {

    let elements: [Element]
    @Binding var index: Int
    @State private var offset: CGFloat = 0
    @State private var isSwiping: Bool = false

    var body: some View {
        GeometryReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(elements) { element in
                        element.frame(width: reader.size.width,
                                      height: reader.size.height)
                    }
                }
            }
            .content
            .offset(x: isSwiping ? offset : (CGFloat(index) * -reader.size.width))
            .frame(width: reader.size.width, alignment: .leading)
            .gesture(
                DragGesture()
                    .onChanged {
                        isSwiping = true
                        offset = $0.translation.width + -reader.size.width * CGFloat(self.index)
                    }
                    .onEnded {
                        if $0.predictedEndTranslation.width < reader.size.width / 2,
                           index < elements.count - 1 { index += 1 }

                        if $0.predictedEndTranslation.width > reader.size.width / 2,
                           index > 0 { index -= 1 }

                        withAnimation { isSwiping = false }
                    }
            )
        }
    }

}
