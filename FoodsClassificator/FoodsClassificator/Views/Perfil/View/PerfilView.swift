//
//  PerfilView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI

struct PerfilView: View {
    
    @StateObject var refeicaoViewModel = RefeicaoCoreDataViewModel()
    
    var viewModel = PerfilViewModel()
    
    @State private var showIdadePopover: Bool = false
    @State private var showPesoPopover: Bool = false
    @State private var showAlturaPopover: Bool = false
    
    @State var textFieldName = ""
    
    @State var idadeSelecionada = 0
    @State var variacaoDaIdade = stride(from: 0, through: 120, by: 1).map { $0 }
    
    @State var pesoSelecionado = 0
    @State var variacaoDoPeso = stride(from: 0, through: 1000, by: 1).map { $0 }
    
    @State var alturaSelecionada = 0
    @State var variacaoDaAltura = stride(from: 0, through: 250, by: 1).map { $0 }
    
    @AppStorage("userName") var userName: String = ""
    @AppStorage("userPhoto") var userPhoto: String = ""
    
    @AppStorage("idade") var idade: Int = 0
    @AppStorage("peso") var peso: Int = 0
    @AppStorage("altura") var altura: Int = 0
    @AppStorage("sexoBiologico") var sexoBiologico: String = ""
    @AppStorage("objetivo") var objetivo: String = ""
    @AppStorage("frequenciaExercicio") var frequenciaExercicio: Int = 0
    
    let sexos: [String] = ["Masculino", "Feminino"]
    @AppStorage("sexoSelecionado") var sexoSelecionado: String = ""
    
    let objetivos: [String] = ["Perder peso", "Manter peso", "Ganhar peso", "Ganhar massa muscular", "Ter uma alimentação balanceada"]
    @AppStorage("objetivoSelecionado") var objetivoSelecionado: String = ""
    
    let frequencias: [Int] = [1, 2, 3, 4, 5]
    @AppStorage("frequenciaSelecionada") var frequenciaSelecionada: Int = 1
    
    @State private var refeicoes = ["Café da manhã", "Almoço", "Jantar"]
    var body: some View {
        
        VStack {
            
            PerfilImageViewComponent(userPhoto: viewModel.userPhoto)
            UserNameComponentPerfilView(userName: viewModel.userName)
            
            Form {
                
                Section {
                    
                    Button {
                        showIdadePopover.toggle()
                    } label: {
                        
                        HStack {
                            Text("Idade")
                            Spacer()
                            Text("\(idade)")
                                .foregroundStyle(.secondary)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                                .imageScale(.small)
                        }.foregroundStyle(.black)
                        
                    }.popover(isPresented: $showIdadePopover) {
                        HStack {
                            Picker("", selection: $idadeSelecionada) {
                                ForEach(0..<variacaoDaIdade.count, id: \.self) { index in
                                    Text("\(variacaoDaIdade[index])")
                                }
                            }
                            .pickerStyle(.wheel)
                            .onChange(of: idadeSelecionada) { _, newValue in
                                idade = variacaoDaIdade[newValue]
                            }
                        }
                        .frame(maxWidth: 150, maxHeight: 120)
                        .presentationCompactAdaptation(.popover)
                    }
                    
                    Button {
                        showPesoPopover.toggle()
                    } label: {
                        
                        HStack {
                            Text("Peso")
                            Spacer()
                            Text("\(peso) kg")
                                .foregroundStyle(.secondary)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                                .imageScale(.small)
                        }.foregroundStyle(.black)
                        
                    }.popover(isPresented: $showPesoPopover) {
                        HStack {
                            Picker("", selection: $pesoSelecionado) {
                                ForEach(0..<variacaoDoPeso.count) {
                                    Text("\(variacaoDoPeso[$0]) kg")
                                }
                            }
                            .pickerStyle(.wheel)
                            .onChange(of: pesoSelecionado) { _, newValue in
                                peso = variacaoDoPeso[newValue]
                            }
                        }
                        .frame(maxWidth: 150, maxHeight: 120)
                        .presentationCompactAdaptation(.popover)
                    }
                    
                    Button {
                        showAlturaPopover.toggle()
                    } label: {
                        
                        HStack {
                            Text("Altura")
                            Spacer()
                            Text("\(altura) cm")
                                .foregroundStyle(.secondary)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                                .imageScale(.small)
                        }.foregroundStyle(.black)
                        
                    }.popover(isPresented: $showAlturaPopover) {
                        HStack {
                            
                            Picker("", selection: $alturaSelecionada) {
                                ForEach(0..<variacaoDaAltura.count) {
                                    Text("\(variacaoDaAltura[$0]) cm")
                                }
                            }
                            .pickerStyle(.wheel)
                            .onChange(of: alturaSelecionada) { _, newValue in
                                altura = variacaoDaAltura[newValue]
                            }
                        }
                        .frame(maxWidth: 150, maxHeight: 120)
                        .presentationCompactAdaptation(.popover)
                    }
                    
                    Picker(selection: $sexoSelecionado) {
                        ForEach(sexos, id: \.self) { sexo in
                            Text(sexo).tag(sexo)
                        }
                    } label: {
                        Text("Sexo Biológico")
                    }.onChange(of: sexoSelecionado) { _, newValue in
                        sexoBiologico = newValue
                    }
                    
                }
                
                Section {
                    
                    Picker(selection: $objetivoSelecionado) {
                        ForEach(objetivos, id: \.self) { objetivo in
                            Text(objetivo).tag(objetivo)
                        }
                    } label: {
                        Text("Objetivo")
                    }
                    .onChange(of: objetivoSelecionado) { _, newValue in
                        objetivo = newValue
                    }
                    
                    Picker(selection: $frequenciaSelecionada) {
                        ForEach(frequencias, id: \.self) { frequencia in
                            Text("\(frequencia)x").tag(frequencia)
                        }
                    } label: {
                        Text("Frequência de exercício")
                    }
                    .onChange(of: frequenciaSelecionada) { _, newValue in
                        frequenciaExercicio = newValue
                    }
                    
                }
                
                Section {
                    
                    ForEach(refeicoes, id: \.self) { refeicao in
                        Text(refeicao)
                    }.onMove(perform: move)
                    
                    ForEach(refeicaoViewModel.refeicoes) { refeicao in
                        Text(refeicao.nome ?? "")
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: moveNew)
                    
                    TextField("Nome da refeição", text: $textFieldName)
                        .onSubmit {
                            guard !textFieldName.isEmpty else { return }
                            refeicaoViewModel.saveRefeicao(nome: textFieldName)
                            textFieldName = ""
                        }
                    
                }
               
            }.background(Color.verdeFundo)
            // permite colocar um background color na list
                .scrollContentBackground(.hidden)
            
                .toolbar {
                    EditButton()
                }
            
        }.background(Color.verdeFundo)
        
    }
    
    func delete(at offsets: IndexSet) {
        refeicaoViewModel.deleteRefeicao(at: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        refeicoes.move(fromOffsets: source, toOffset: destination)
    }
    
    func moveNew(from source: IndexSet, to destination: Int) {
        refeicaoViewModel.refeicoes.move(fromOffsets: source, toOffset: destination)
    }
    
}

#Preview {
    PerfilView()
}
