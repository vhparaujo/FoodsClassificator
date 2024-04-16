//
//  PerfilView.swift
//  FoodsClassificator
//
//  Created by Victor Hugo Pacheco Araujo on 27/03/24.
//

import SwiftUI
import PhotosUI
import SwiftData

struct PerfilView: View {
    
    @Bindable var perfilViewModel: PerfilViewModel
    
    @Environment(\.editMode) private var editMode
    @Environment(\.modelContext) private var context
    
    @State private var showIdadePopover: Bool = false
    @State private var showPesoPopover: Bool = false
    @State private var showAlturaPopover: Bool = false
    
    var body: some View {
        
        VStack {
            
            if canEditFunc() == true {
                
                PerfilImagePickerViewComponent(viewModel: perfilViewModel)
                    .frame(width: 100, height: 100)
                
                UserNameComponentPerfilView(userName: $perfilViewModel.model.userName)
                
            } else {
                
                PerfilImageViewComponent(perfilViewModel: perfilViewModel)
                    .frame(width: 100, height: 100)
                
                HStack(alignment: .center) {
                    if perfilViewModel.model.userName == "" {
                        Text("Olá")
                            .font(.title)
                            .foregroundStyle(.verdeTitle)
                    } else {
                        Text("Olá, \(perfilViewModel.model.userName)!")
                            .font(.title)
                            .foregroundStyle(.verdeTitle)
                    }
                }
                
            }
            
            List {
                Section {
                    
                    Button {
                        showIdadePopover.toggle()
                    } label: {
                        
                        HStack {
                            Text("Idade")
                            Spacer()
                            Text("\(perfilViewModel.model.idade)")
                                .foregroundStyle(canEditFunc() ? .secondary : .tertiary)
                            if canEditFunc() {
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                                    .imageScale(.small)
                            }
                            
                        }.foregroundStyle(.black)
                        
                    }
                    .disabled(!canEditFunc())
                    .popover(isPresented: $showIdadePopover) {
                        HStack {
                            Picker("", selection: $perfilViewModel.model.idade) {
                                ForEach(0..<perfilViewModel.variacaoDaIdade.count, id: \.self) {
                                    Text("\(perfilViewModel.variacaoDaIdade[$0])").tag(perfilViewModel.variacaoDaIdade[$0])
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
                            Text("\(perfilViewModel.model.peso) kg")
                                .foregroundStyle(canEditFunc() ? .secondary : .tertiary)
                            if canEditFunc() {
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                                    .imageScale(.small)
                            }
                        }.foregroundStyle(.black)
                        
                    }
                    .disabled(!canEditFunc())
                    .popover(isPresented: $showPesoPopover) {
                        HStack {
                            Picker("", selection: $perfilViewModel.model.peso) {
                                ForEach(0..<perfilViewModel.variacaoDoPeso.count, id: \.self) {
                                    Text("\(perfilViewModel.variacaoDoPeso[$0]) kg").tag(perfilViewModel.variacaoDoPeso[$0])
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
                            Text("\(perfilViewModel.model.altura) cm")
                                .foregroundStyle(canEditFunc() ? .secondary : .tertiary)
                            if canEditFunc() {
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                                    .imageScale(.small)
                            }
                        }.foregroundStyle(.black)
                        
                    }
                    .disabled(!canEditFunc())
                    .popover(isPresented: $showAlturaPopover) {
                        HStack {
                            
                            Picker("", selection: $perfilViewModel.model.altura) {
                                ForEach(0..<perfilViewModel.variacaoDaAltura.count, id: \.self) {
                                    Text("\(perfilViewModel.variacaoDaAltura[$0]) cm").tag(perfilViewModel.variacaoDaAltura[$0])
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        .frame(maxWidth: 150, maxHeight: 120)
                        .presentationCompactAdaptation(.popover)
                    }
                    
                    if canEditFunc() == true {
                        
                        Picker(selection: $perfilViewModel.model.sexoBiologico) {
                            ForEach(perfilViewModel.sexos, id: \.self) { sexo in
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
                            Text("\(perfilViewModel.model.sexoBiologico)")
                                .foregroundStyle(.tertiary)
                        }
                    }
                    
                }
                
                Section {
                    
                    if canEditFunc() == true {
                        
                        Picker(selection: $perfilViewModel.model.objetivo) {
                            ForEach(perfilViewModel.objetivos, id: \.self) { objetivo in
                                Text(objetivo).tag(objetivo)
                            }
                        } label: {
                            Text("Objetivo")
                        }
                        
                    } else {
                        HStack {
                            Text("Objetivo")
                            Spacer()
                            Text("\(perfilViewModel.model.objetivo)")
                                .foregroundStyle(.tertiary)
                        }
                    }
                    
                    if canEditFunc() == true {
                        
                        Picker(selection: $perfilViewModel.model.intensidadeDoExercicio) {
                            ForEach(perfilViewModel.intensidades, id: \.self) { intensidade in
                                Text("\(intensidade)")
                                    .tag(intensidade)
                            }
                        } label: {
                            Text("Intensidade de exercício")
                        }
                        
                    } else {
                        HStack {
                            Text("Intensidade de exercício")
                            Spacer()
                            Text("\(perfilViewModel.model.intensidadeDoExercicio)")
                                .foregroundStyle(.tertiary)
                        }
                    }
                    
                }
                
                Section {
                    
                    ForEach(perfilViewModel.model.refeicoes.indices, id: \.self) { index in
                        TextField("", text: $perfilViewModel.model.refeicoes[index]).tag(perfilViewModel.model.refeicoes[index])
                    }
                    .onDelete(perform: perfilViewModel.model.refeicoes.count > 1 ? delete : nil)
                    .onMove(perform: move)
                    
                    TextField("Nome da refeição", text: $perfilViewModel.textFieldName)
                        .onSubmit {
                            perfilViewModel.model.refeicoes.append(perfilViewModel.textFieldName)
                            perfilViewModel.textFieldName = ""
                        }
                        .disabled(!canEditFunc())
                    
                }
                
            }.background(Color.verdeFundo)
            // permite colocar um background color na list
                .scrollContentBackground(.hidden)
            
                .toolbar {
                    EditButton()
                }
            
        }.background(Color.verdeFundo)
        
            .onAppear(perform: {
                perfilViewModel.modelContext = context
            })
        
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        
    }
    
    func delete(at offsets: IndexSet) {
        perfilViewModel.model.refeicoes.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        perfilViewModel.model.refeicoes.move(fromOffsets: source, toOffset: destination)
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
    NavigationStack {
        let modelContainer: ModelContainer = .appContainer
        return PerfilView(perfilViewModel: PerfilViewModel()).modelContainer(modelContainer)
    }
}
