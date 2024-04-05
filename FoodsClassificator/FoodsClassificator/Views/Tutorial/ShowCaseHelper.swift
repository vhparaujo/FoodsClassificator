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
    var onFinished: () -> ()
    
    ///view properties
    @State private var highlightOrder: [Int] = []
    @State private var currentHighlight: Int = 0
    @State private var showView:Bool = true
    ///Popover
    @State private var showTitle:Bool = false
    ///Namespace ID , for smooth Shape Transition
    @Namespace private var animation
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(HighlightAnchorKey.self) { value in
                highlightOrder = Array(value.keys).sorted()
            }
            .overlayPreferenceValue(HighlightAnchorKey.self) { preferences in
                if highlightOrder.indices.contains(currentHighlight), showHighlights, showView {
                    if let highlight = preferences[highlightOrder[currentHighlight]] {
                        HighlightView(highlight)
                    }
                }
            }
    }
    
    ///Highlight View
    @ViewBuilder
    func HighlightView(_ highlight: Highlight) -> some View {
        GeometryReader { proxy in
            let highlightRect = proxy[highlight.anchor]
            let safeArea = proxy.safeAreaInsets
            Rectangle()
                .fill(.black.opacity(0.5))
                .reverseMask {
                    Rectangle()
                        .matchedGeometryEffect(id: "HIGHLIGHTEDSHAPE", in: animation)
                    ///ading Border
                    //////simply Extend it's size
                        .frame(width: highlightRect.width + 5,
                               height: highlightRect.height + 5)
                        .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
                        .scaleEffect(highlight.scale)
                        .offset(x: highlightRect.minX - 2.5, y: highlightRect.minY + safeArea.top - 2.5)
                }
                .ignoresSafeArea()
                .onTapGesture {
                    if currentHighlight >= highlightOrder.count - 1 {
                        ///hides the hilightView
                        withAnimation(.easeInOut(duration: 0.25)){
                            showView = false
                        }
                        onFinished()
                    } else {
                        ///Move to the next highligh
                        withAnimation(.interactiveSpring(response: 0.3,
                                                         dampingFraction: 0.7,
                                                         blendDuration: 0.7)){
                            showTitle = false
                            currentHighlight += 1
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
                            showTitle = true
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showTitle = true
                    }
                }
            
            Rectangle()
                .foregroundStyle(Color.clear)
            ///ading Border
            //////simply Extend it's size
                .frame(width: highlightRect.width + 20,
                       height: highlightRect.height + 20)
                .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius,
                                            style: highlight.style))
                .popover(isPresented: $showTitle){
                    Text(highlight.title)
                        .padding()
                        .presentationCompactAdaptation(.popover)
                        .interactiveDismissDisabled()
                }
                .scaleEffect(highlight.scale)
                .offset(x: highlightRect.minX - 10, y: highlightRect.minY - 10)
            
            
            
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
                    .overlay(alignment: .topLeading) {
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
    TutorialHomeView()
}
