//
//  Tip.swift
//  FoodsClassificator
//
//  Created by Gabriel Ribeiro Noronha on 03/04/24.
//

import Foundation
import TipKit

struct FirstUseTips: Tip {
    var title: Text{
        Text("Titulo")
    }
    var message: Text? {
        Text("Registre suas refeições facilmente! Use a câmera para alimentos ou código de barras, ou apenas pesquise. Veja as calorias e nutrientes de cada refeição enquanto registra sua alimentação.")
    }
    var image: Image?{
        Image("PapaiaTip1")
    }
}
