//
//  ProgressBar.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 08/04/24.
//

import SwiftUI

struct FormProgressBar: View {
    
    @Binding var percent: CGFloat
    
    var body: some View {
        
        
        ZStack (alignment: .leading){
            ZStack(alignment: .trailing){
                Capsule()
                    .fill(Color.black.opacity(0.1))
                    .frame(width: UIScreen.main.bounds.width * 0.91
                           ,height: UIScreen.main.bounds.height * 0.004)
            }
            
            Capsule()
                .fill(Color.laranjaEscuro)
                .frame(width: UIScreen.main.bounds.width * percent,
                       height: UIScreen.main.bounds.height * 0.004)
        }
    }
}

#Preview {
    FormProgressBar(percent: .constant(010))
}
