//
//  TutorialPage1.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 04/04/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    
    func showCase(order: Int, title: String, cornerRadius: CGFloat, style: RoundedCornerStyle, scale: CGFloat = 1, popoverType: PopoverType = .standard) -> some View {
        self
            .anchorPreference(key: HighlightAnchorKey.self, value: .bounds) { anchor in
                let highlight = Highlight(anchor: anchor,
                                          title: title,
                                          cornerRadius: cornerRadius,
                                          style: style,
                                          scale: scale, popoverType: popoverType)
                return [order: highlight]
            }
    }
}

///Showcase Root View Modifier
struct ShowCaseRoot: ViewModifier{
    @Binding var showStartPopover: Bool
    var showHighlights: Bool
    var onFinished: () -> ()
    
    ///view properties
    @State private var highlightOrder: [Int] = []
    @State private var currentHighlight: Int = 0
    @Binding var showView: Bool

    ///Popover
    @State private var showTitle:Bool = false
    ///Namespace ID , for smooth Shape Transition
    @Namespace private var animation
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(HighlightAnchorKey.self) { value in
                highlightOrder = Array(value.keys).sorted()
                //                showStartPopover = true  // Abre o popover automaticamente
                //                        onFinished()
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
                    if currentHighlight < highlightOrder.count - 1 {
                        withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.7)) {
                            showTitle = false
                            currentHighlight += 1
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            showTitle = true
                            if currentHighlight == highlightOrder.count - 1 {
                                // Iniciar a exibição do popover automaticamente após o último showcase ser mostrado
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    showStartPopover = true
                                }
                            }
                        }
                    } else {
                        // Ação ao finalizar o último showcase
                        withAnimation(.easeInOut(duration: 0.25)) {
                             // Altere conforme a lógica necessária para esconder o view
                            showStartPopover = true
                            showView = false

                        }
                        onFinished() // Chama ação de finalização se houver
                    }
                }
            
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showTitle = true
                    }
                }
            switch highlight.popoverType {
            case .standard:
                Rectangle()
                    .foregroundStyle(Color.clear)
                    .frame(width: highlightRect.width + 20,
                           height: highlightRect.height + 20)
                    .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius,
                                                style: highlight.style))
                    .popover(isPresented: $showTitle){
                        Text(highlight.title)
                            .lineLimit(nil) // Permite um número ilimitado de linhas
                            .fixedSize(horizontal: false, vertical: true)
                            .padding()
                            .presentationCompactAdaptation(.popover)
                            .interactiveDismissDisabled()
                            .frame(height: 150)
                    }
                    .scaleEffect(highlight.scale)
                    .scaledToFit()
                    .offset(x: highlightRect.minX - 10, y: highlightRect.minY - 10)
                
            case .custom:
                Rectangle()
                    .foregroundStyle(Color.clear)
                    .frame(width: highlightRect.width + 20, height: highlightRect.height + 20)
                    .clipShape(RoundedRectangle(cornerRadius: highlight.cornerRadius, style: highlight.style))
                //                    .popover(isPresented: $showTitle) {
                //                        CustomAlertView(
                //                            title: highlight.title,
                //                            onConfirm: {
                //                                // Aqui vai a lógica quando o usuário tocar em "Confirmar"
                //                                print("Confirmado")
                //                            },
                //                            onCancel: {
                //                                // Aqui vai a lógica quando o usuário tocar em "Cancelar"
                //                                print("Cancelado")
                //                            }
                //                        )
                //                        .frame(width: 300, height: 200) // Ajuste o tamanho conforme necessário
                //                    }
                //                    .scaleEffect(highlight.scale)
                //                    .offset(x: highlightRect.minX - 10, y: highlightRect.minY - 10)
                
            case .vazio:
                RoundedRectangle(cornerRadius: 10)
                    .frame( width: 0, height: 0)
                    .opacity(0.4)
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

//#Preview {
//    TutorialHomeViewTeste()
//}
