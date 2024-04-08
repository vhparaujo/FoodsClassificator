//
//  FormsPage3.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI

struct FormsPage3: View {
    @State private var gender = 0
    let genders = ["Female", "Male"]
    
    var body: some View {
        NavigationStack {
            VStack {
                FormProgressBar(percent: .constant(0.48))
                
                Group {
                    QuestionTextComponent(QuestionLabel: "Qual o seu sexo biológico?")
                }
                
                HStack{
                    ForEach(0..<genders.count, id: \.self) { index in
                        Button(action: {
                            self.gender = index
                            print(genders[index])
                            
                        }) {
                            Capsule()
                                .foregroundStyle(.green.opacity(0.4))
                                .overlay {
                                    Text(genders[index])                                        .tint(.black)
                                }
                                .frame(height: 50)
                                .opacity(gender == index ? 1.0 : 0.5)
                        }
                    }
                }
                
                Spacer()
                
                Image("form_page3")
                
                Spacer()
                
                // NavigationLink para a próxima página do questionário
                NavigationLink(destination: FormsPage4()) {
                    NextButtonLabel(nextButtonLabel: "Próximo")
                }
            }
            .padding()
        }
    }
}


#Preview {
    FormsPage3()
}
