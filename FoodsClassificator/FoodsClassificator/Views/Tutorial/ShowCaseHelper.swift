//
//  TutorialPage1.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 04/04/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func showCase(order: Int, title: String, cornerRadius: CGFloat, style: RoundedCornerStyle, scale: CGFloat = 1) -> some View {
        self
            .anchorPreference(key: HighlightAnchorKey.self, value: .bounds) { anchor in
                let highlight = Highlight(anchor: anchor,
                                          title: title,
                                          cornerRadius: cornerRadius,
                                          style: style,
                                          scale: scale)
                return [order: highlight]
            }
    }
}

///Showcase Root View Modifier

struct ShowCaseRoot: ViewModifier{
    var showHighlights: Bool
    var onFinish: () -> ()
    
    ///view properties
    @State private var highlightOrder: [Int] = []
    @State private var currentHighlight: Int = 0
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(HighlightAnchorKey.self) { value in
                highlightOrder = Array(value.keys)
            }
            .overlayPreferenceValue(HighlightAnchorKey.self) { preferences in
                if highlightOrder.indices.contains(currentHighlight) {
                    if let highlight = preferences[highlightOrder[currentHighlight]] {
                        
                    }
                }
            }
    }
    
    ///Highlight View
    @ViewBuilder
    func HighlightView(_ highlight: Highlight) -> some View {
        GeometryReader{ proxy in
            let highloightRect = proxy[highlight.anchor]
            Rectangle()
                .reverseMask {
                    Rectangle()
                    ///ading Border
                    //////simply Extend it's size
                        .frame(width: highloightRect.width, height: highloightRect.height)
                        .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
                        .offset(x: highloightRect.minX, y: highloightRect.minY)
                }
        }
    }
}

///Custom View Modifier For Inner/Reverse Masl
extension View {
    @ViewBuilder
    func reverseMask<Content: View>(alignment:Alignment = .topLeading, @ViewBuilder content: @escaping () -> Content ) -> some View {
        self
            .mask {
                Rectangle()
                    .overlay(alignment: .leading) {
                        content()
                            .blendMode(.destinationOut)
                    }
            }
    }
}


///AnchorKey
fileprivate struct HighlightAnchorKey: PreferenceKey {
    static var defaultValue: [Int: Highlight] = [:]
    
    static func reduce(value: inout [Int : Highlight], nextValue: () -> [Int : Highlight]) {
        value.merge(nextValue()) { $1 }
    }
}

#Preview {
    HomeView()
}
