//
//  ContextIndicatorView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 31/07/2021.
//

import SwiftUI

struct ContextIndicatorView: View {

    let contexts: [String]
    @Binding var index: Int
    @State private var contextWidths: PageIndicatorView.IndexedWidthKey.Value = [:]

    var body: some View {
        GeometryReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 15) {
                    ForEach(contexts.indices) { index in
                        PageIndicatorView(isFocused: Binding<Bool>(get: { self.index == index }, set: { _ in }),
                                          type: .text(value: contexts[index]),
                                          index: index)
                    }
                }
                .onPreferenceChange(PageIndicatorView.IndexedWidthKey.self) { contextWidths = $0 }
            }
            .offset(x: offset(reader.size.width))
            .frame(width: reader.size.width, height: 30, alignment: .leading)
        }.frame(height: 30, alignment: .leading)
    }

    private func offset(_ containerWidth: CGFloat) -> CGFloat {
        guard index < contexts.count else { return 0 }
        let totalWidth = cumulativeWidth(toIndex: contexts.count)
        guard totalWidth > containerWidth else { return 0 }

        return -cumulativeWidth(toIndex: index)
    }

    private func cumulativeWidth(toIndex index: Int) -> CGFloat {
        var currentIndex: Int = 0
        var cumulative: CGFloat = 0

        while currentIndex < index, let width = contextWidths[currentIndex] {
            cumulative += width + 15
            currentIndex += 1
        }

        if index == contexts.count { cumulative -= 15 }

        return cumulative
    }

}

// MARK: - Preview

#if DEBUG

struct ContextIndicatorView_Previews: PreviewProvider {

    @State static private var index: Int = 2

    static var previews: some View {
        ContextIndicatorView(contexts: ["Pizza", "Sushi", "Drinks"],
                             index: $index)

        ContextIndicatorView(contexts: ["Pizza", "Sushi", "Drinks", "Dessert"],
                             index: $index)
    }

}

#endif
