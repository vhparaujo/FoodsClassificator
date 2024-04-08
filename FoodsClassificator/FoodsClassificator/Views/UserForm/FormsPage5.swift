//
//  FormsPage5.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI

struct FormsPage5: View {
    @State private var refeicao = 0
    let refeicoes:[String] = ["Café da manhã", "Lanche da manhã", "Almoço", "Lanche da tarde", "Jantar"]
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    FormProgressBar(percent: .constant(0.80))
                }
                
                Group {
                    QuestionTextComponent(QuestionLabel: "Quais refeições você faz por dia?")
                    
                    VStack{
                        ForEach(0..<refeicoes.count, id: \.self) { index in
                            Button(action: {
                                self.refeicao = index
                                print(refeicoes[index])
                                print(refeicao)
                            }) {
                                Capsule()
                                    .foregroundStyle(.green.opacity(0.4))
                                    .overlay {
                                        HStack {
                                            Text(refeicoes[index])                       
                                                .tint(.black)
                                            Spacer()
                                            Image(systemName: "list.bullet")
                                                .foregroundStyle(Color.black)
                                        }
                                        .padding(.horizontal)
                                    }
                                    .frame(height: 50)
                                    .opacity(refeicao == index ? 1.0 : 0.5)
                                
                            }
                            
                        }
                    }
                }
                
                Spacer()
                
                
                // NavigationLink para a próxima página do questionário
                NavigationLink(destination: FormsPage6()) {
                    NextButtonLabel(nextButtonLabel: "Próximo")
                }
            }
            .padding()
        }
    }
}


#Preview {
    FormsPage5()
}
