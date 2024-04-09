//
//  SpeechRecognizerManager.swift
//  FoodsClassificator
//
//  Created by Bruno Souza on 07/04/24.
//

import Speech
import AVFoundation

class SpeechRecognizerManager: ObservableObject {
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "pt-BR"))
    private var recognitionTask: SFSpeechRecognitionTask?
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest? // A variável foi adicionada aqui
    private let audioEngine = AVAudioEngine()
    
    @Published var isListening: Bool = false
    @Published var recognizedText: String = ""
    
    func requestPermission() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    print("Usuário concedeu permissão para reconhecimento de voz.")
                    self.isListening = true
                case .denied:
                    print("Usuário negou permissão para reconhecimento de voz.")
                    self.isListening = false
                case .restricted:
                    print("Reconhecimento de voz restrito neste dispositivo.")
                    self.isListening = false
                case .notDetermined:
                    print("Permissão para reconhecimento de voz não determinada.")
                    self.isListening = false
                @unknown default:
                    print("Estado de permissão desconhecido.")
                    self.isListening = false
                }
            }
        }
    }
    
    func startListening() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            isListening = false
            print("Parando reconhecimento de voz...")
        } else {
            do {
                try startRecording()
                isListening = true
                print("Iniciando reconhecimento de voz...")
            } catch {
                print("Falha ao iniciar o reconhecimento de voz: \(error)")
            }
        }
    }

    private func startRecording() throws {
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        print("Sessão de áudio configurada.")
        
        let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        self.recognitionRequest = recognitionRequest
        recognitionRequest.shouldReportPartialResults = true
        print("Request de reconhecimento configurado para resultados parciais.")
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.removeTap(onBus: 0) // Remover qualquer tap anterior
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            recognitionRequest.append(buffer)
        }
        print("Tap instalado no inputNode.")
        
        audioEngine.prepare()
        try audioEngine.start()
        print("Audio engine iniciado.")
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                DispatchQueue.main.async {
                    self.recognizedText = result.bestTranscription.formattedString
                    isFinal = result.isFinal
                    print("Texto reconhecido: \(self.recognizedText)")
                }
            }
            
            if error != nil || isFinal {
                DispatchQueue.main.async {
                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    
                    self.recognitionRequest = nil
                    self.recognitionTask = nil
                    
                    self.isListening = false
                    print("Reconhecimento de voz parado. \(error?.localizedDescription ?? "")")
                }
            }
        }
    }

    func stopListening() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
        isListening = false
        print("Parando de ouvir explicitamente.")
    }
    
    deinit {
        stopListening()
    }
}
