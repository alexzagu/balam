//
//  PageIndicatorView.swift
//  Balam
//
//  Created by Alejandro Zamudio Guajardo on 29/07/2021.
//

import SwiftUI

struct PageIndicatorView: View {

    @Binding var isFocused: Bool
    let type: IndicatorType
    let index: IndicatorIndex
    @State private var contentSize: CGSize?

    var body: some View {
        content
            .background(
                GeometryReader {
                    Color.clear
                        .preference(key: IndexedWidthKey.self, value: [index: $0.size.width])
                        .preference(key: SizeKey.self, value: $0.size)
                }
            )
            .onPreferenceChange(SizeKey.self) { contentSize = $0 }
            .frame(width: contentSize?.width,
                   height: contentSize?.height,
                   alignment: .center)
    }

}

// MARK: - Content

extension PageIndicatorView {

    private var content: AnyView {
        switch type {
        case .dot: return AnyView(dot)
        case let .text(value): return AnyView(text(value))
        }
    }

    private var dot: some View {
        Circle()
            .frame(width: dimension, height: dimension)
            .foregroundColor(.white)
            .animation(.linear)
    }

    private func text(_ value: String) -> some View {
        Text(value)
            .foregroundColor(.black.opacity(isFocused ? 1.0 : 0.2))
            .font(.system(size: 30, weight: .semibold))
            .lineLimit(1)
            .truncationMode(.middle)
            .multilineTextAlignment(.center)
            .animation(.linear)
    }

    private var dimension: CGFloat {
        isFocused ? 12 : 6
    }

}

// MARK: - Definitions

extension PageIndicatorView {

    typealias IndicatorIndex = Int

    enum IndicatorType {

        case dot
        case text(value: String)

    }

    struct IndexedWidthKey: PreferenceKey {

        static var defaultValue: [Int: CGFloat] = [:]

        static func reduce(value: inout [Int: CGFloat], nextValue: () -> [Int: CGFloat]) {
            value.merge(nextValue()) { (_, new) in new }
        }

    }

    struct SizeKey: PreferenceKey {

        static var defaultValue: CGSize? { nil }

        static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
            value = nextValue()
        }

    }
    
}

// MARK: - Preview

#if DEBUG

struct PageIndicatorView_Previews: PreviewProvider {

    @State private static var isFocused: Bool = false

    static var previews: some View {
        Group {
            PageIndicatorView(isFocused: $isFocused,
                              type: .dot,
                              index: 0)

            PageIndicatorView(isFocused: $isFocused,
                              type: .text(value: "Indicator"),
                              index: 1)
        }
    }

}

#endif
