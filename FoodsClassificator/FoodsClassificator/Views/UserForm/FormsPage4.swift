//
//  FormsPage4.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI

struct FormsPage4: View {
    @State private var objective = 0
    let objectives:[String] = ["Perder Peso", "Manter Peso", "Ganhar Peso", "Ganhar massa muscular", "Ter uma Alimentação Balanceada"]
    @State private var activity = 0
    let activityLevels = ["1x", "2x", "3x", "4x", "5x", "6x", "7x"]
    
    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    FormProgressBar(percent: .constant(0.64))
                }
                
                Group {
                    QuestionTextComponent(QuestionLabel: "Qual é o seu principal objetivo?")
                }
                
                Group {
                    VStack{
                        ForEach(0..<objectives.count, id: \.self) { index in
                            Button(action: {
                                self.objective = index
                                print(objectives[index])
                                print(objective)
                            }) {
                                Capsule()
                                    .foregroundStyle(.green.opacity(0.4))
                                    .overlay {
                                        Text(objectives[index])                         .tint(.black)
                                    }
                                    .frame(height: 50)
                                    .opacity(objective == index ? 1.0 : 0.5)
                            }
                        }
                    }
                }
                
                Spacer()
                
                Group {
                    QuestionTextComponent(QuestionLabel: "Quantas vezes na semana você pratica exercício físico?")
                    HStack(spacing: 10){
                        ForEach(0..<activityLevels.count, id: \.self) { index in
                            Button(action: {
                                self.activity = index
                                print(activityLevels[index])
                                print(activity)
                            }) {
                                RoundedRectangle(cornerRadius: 15)
                                    .foregroundStyle(.green.opacity(0.4))
                                    .overlay {
                                        Text(activityLevels[index])                         .tint(.black)
                                    }
                                    .frame(height: 50)
                                    .opacity(activity == index ? 1.0 : 0.5)
                            }
                        }
                    }
                }
                
                
                            
                Spacer()
                
                // NavigationLink para a próxima página do questionário
                NavigationLink(destination: FormsPage5()) {
                    NextButtonLabel(nextButtonLabel: "Próximo")
                }
            }
            .padding()
        }
    }
}

#Preview {
    FormsPage4()
}
