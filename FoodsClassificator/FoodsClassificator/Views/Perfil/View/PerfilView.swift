//
//  PerfilView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI

struct PerfilView: View {
    
    @Bindable private var viewModel = PerfilViewModel()

    @Environment(\.editMode) private var editMode
    @Environment(\.modelContext) private var context

    @State private var showIdadePopover: Bool = false
    @State private var showPesoPopover: Bool = false
    @State private var showAlturaPopover: Bool = false

    var body: some View {
        
        VStack {
            
            PerfilImageViewComponent(userPhoto: $viewModel.model.userPhoto)
                .frame(width: 100, height: 100)
            
            UserNameComponentPerfilView(userName: $viewModel.model.userName)
            
            Form {
                
                Section {
                    
                    Button {
                        showIdadePopover.toggle()
                    } label: {
                        
                        HStack {
                            Text("Idade")
                            Spacer()
                            Text("\(viewModel.model.idade)")
                                .foregroundStyle(canEditFunc() ? .secondary : .tertiary)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.secondary)
                                .opacity(canEditFunc() ? 1 : 0)
                                .imageScale(.small)
                        }.foregroundStyle(.black)
                        
                    }
                    .disabled(!canEditFunc())
                    .popover(isPresented: $showIdadePopover) {
                        HStack {
                            Picker("", selection: $viewModel.model.idade) {
                                ForEach(0..<viewModel.variacaoDaIdade.count, id: \.self) {
                                    Text("\(viewModel.variacaoDaIdade[$0])").tag(viewModel.variacaoDaIdade[$0])
                                }
                            }
                            .pickerStyle(.wheel)
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
                            Text("\(viewModel.model.peso) kg")
                                .foregroundStyle(.tertiary)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                                .imageScale(.small)
                        }.foregroundStyle(.black)
                        
                    }
                    .disabled(!canEditFunc())
                    .popover(isPresented: $showPesoPopover) {
                        HStack {
                            Picker("", selection: $viewModel.model.peso) {
                                ForEach(0..<viewModel.variacaoDoPeso.count, id: \.self) {
                                    Text("\(viewModel.variacaoDoPeso[$0]) kg").tag(viewModel.variacaoDoPeso[$0])
                                }
                            }
                            .pickerStyle(.wheel)
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
                            Text("\(viewModel.model.altura) cm")
                                .foregroundStyle(.tertiary)
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.tertiary)
                                .imageScale(.small)
                        }.foregroundStyle(.black)
                        
                    }
                    .disabled(!canEditFunc())
                    .popover(isPresented: $showAlturaPopover) {
                        HStack {
                            
                            Picker("", selection: $viewModel.model.altura) {
                                ForEach(0..<viewModel.variacaoDaAltura.count, id: \.self) {
                                    Text("\(viewModel.variacaoDaAltura[$0]) cm").tag(viewModel.variacaoDaAltura[$0])
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        .frame(maxWidth: 150, maxHeight: 120)
                        .presentationCompactAdaptation(.popover)
                    }
                    
                    if canEditFunc() == true {
                        
                        Picker(selection: $viewModel.model.sexoBiologico) {
                            ForEach(viewModel.sexos, id: \.self) { sexo in
                                Text(sexo).tag(sexo)
                            }
                        } label: {
                            Text("Sexo Biológico")
                        }
                        .disabled(!canEditFunc())
                    
                    } else {
                        HStack {
                            Text("Sexo Biológico")
                            Spacer()
                            Text("\(viewModel.model.sexoBiologico)")
                                .foregroundStyle(.tertiary)
                            Image(systemName: "chevron.up.chevron.down")
                                .foregroundStyle(.tertiary)
                        }
                    }
                    
                }
                
                Section {
                    
                    if canEditFunc() == true {
                        
                        Picker(selection: $viewModel.model.objetivo) {
                            ForEach(viewModel.objetivos, id: \.self) { objetivo in
                                Text(objetivo).tag(objetivo)
                            }
                        } label: {
                            Text("Objetivo")
                        }
                        
                    } else {
                        HStack {
                            Text("Objetivo")
                            Spacer()
                            Text("\(viewModel.model.objetivo)")
                                .foregroundStyle(.tertiary)
                            Image(systemName: "chevron.up.chevron.down")
                                .foregroundStyle(.tertiary)
                        }
                    }
                    
                    if canEditFunc() == true {
                        
                        Picker(selection: $viewModel.model.frequenciaExercicio) {
                            ForEach(viewModel.frequencias, id: \.self) { frequencia in
                                Text("\(frequencia)x")
                                    .tag(frequencia)
                            }
                        } label: {
                            Text("Frequência de exercício")
                        }
                        
                    } else {
                        HStack {
                            Text("Frequência de exercício")
                            Spacer()
                            Text("\(viewModel.model.frequenciaExercicio)x")
                                .foregroundStyle(.tertiary)
                        }
                    }
                    
                }
                
                Section {
                    
                    ForEach(viewModel.refeicoesFixas, id: \.self) { refeicao in
                        Text(refeicao).tag(refeicao)
                    }
                    
                    ForEach(viewModel.model.refeicoes.indices, id: \.self) { index in
                        TextField("", text: $viewModel.model.refeicoes[index]).tag(viewModel.model.refeicoes[index])
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)
                    
                    TextField("Nome da refeição", text: $viewModel.textFieldName)
                        .onSubmit {
                            viewModel.model.refeicoes.append(viewModel.textFieldName)
                            viewModel.textFieldName = ""
                        }
                    
                }
                
            }.background(Color.verdeFundo)
            // permite colocar um background color na list
                .scrollContentBackground(.hidden)
            
                .toolbar {
                    EditButton()
                }
            
        }.background(Color.verdeFundo)
        
            .onAppear(perform: {
                viewModel.modelContext = context
            })
        
    }
    
    func delete(at offsets: IndexSet) {
        viewModel.model.refeicoes.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        viewModel.model.refeicoes.move(fromOffsets: source, toOffset: destination)
    }
    
    func canEditFunc() -> Bool {
        if editMode?.wrappedValue.isEditing == true {
            return true
        } else {
            return false
        }
    }
    
}

#Preview {
    PerfilView()
        .modelContainer(appContainer)
}
