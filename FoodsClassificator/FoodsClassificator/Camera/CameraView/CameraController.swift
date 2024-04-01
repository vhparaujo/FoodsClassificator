//
//  CameraController.swift
//  FoodsClassificator
//
//  Created by Arthur Dos Reis on 26/03/24.
//

import AVFoundation
import UIKit

class CameraController: NSObject, ObservableObject{
    
    var captureSession: AVCaptureSession?
    private let metadataOutput = AVCaptureMetadataOutput()
    private let videoOutput = AVCaptureVideoDataOutput()
    private var previewLayer:AVCaptureVideoPreviewLayer?
    private var backCamera: AVCaptureDevice?
    @Published var isStatusBarHidden = false

    private var darkOverlayLayer: CALayer?
    private var redLineLayer: CALayer?

    
    override init(){
        super.init()
        setupCaptureSession()
    }
    
    //MARK: - Configuração camera
    func setupCaptureSession(){
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .hd1920x1080
        
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            DispatchQueue.main.async {
                print("Unable to access back camera!")
            }
            return
        }
        
        self.backCamera = backCamera
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            captureSession?.addInput(input)
        } catch let error {
            print("Error Unable to initialize back camera: \(error.localizedDescription)")
            return
        }
        
        //MARK: - If a baixo é responsavel pela inicialização do scanner de codigos de barra
        
        if ((captureSession?.canAddOutput(metadataOutput)) != nil) {
            captureSession?.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            let supportedTypes = metadataOutput.availableMetadataObjectTypes
            var desiredTypes: [AVMetadataObject.ObjectType] = [.ean8, .ean13, .pdf417]
            desiredTypes = desiredTypes.filter { supportedTypes.contains($0) }
            
            if !desiredTypes.isEmpty {
                metadataOutput.metadataObjectTypes = desiredTypes
            } else {
                print("Nenhum dos tipos de metadados desejados é suportado pelo dispositivo.")
            }
        } else {
            print("Error to scanning code.")
            return
        }

        self.videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        if captureSession?.canAddOutput(videoOutput) == true {
            captureSession?.addOutput(videoOutput)
        }
    }
    
    //MARK: - Função ligar camera
    func startRunning() {
        print("Iniciando Camera")
        isStatusBarHidden = true
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession?.startRunning()
        }
    }
    
    //MARK: - Função desligar camera
    func stopRunning() {
        isStatusBarHidden = false
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.captureSession?.stopRunning()
        }
    }
    
    //MARK: - Função ligar flash
    func enableTorch() {
        guard let backCamera = backCamera, backCamera.hasTorch && backCamera.isTorchAvailable else {
            print("Torch (flash) not available")
            return
        }
        
        do {
            try backCamera.lockForConfiguration()
            backCamera.torchMode = .on
            backCamera.unlockForConfiguration()
        } catch {
            print("Error trying to enable torch: \(error)")
        }
    }

    //MARK: - Função desligar flash
    func disableTorch() {
        guard let backCamera = backCamera, backCamera.hasTorch else {
            return
        }
        
        do {
            try backCamera.lockForConfiguration()
            backCamera.torchMode = .off
            backCamera.unlockForConfiguration()
        } catch {
            print("Error trying to disable torch: \(error)")
        }
    }
    
    //MARK: - Retorna o capture session que foi configurado na função acima, essa função é chamada na CameraPreview aonde é exibida a camera
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer {
        if self.previewLayer == nil {
            self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            self.previewLayer?.videoGravity = .resizeAspectFill
        }
                
        return self.previewLayer!
    }
    
    func setupCameraOverlay() {
        guard let previewLayer = self.previewLayer else { return }

        // Cria uma camada escura para cobrir a tela inteira
        let darkLayer = CALayer()
        darkLayer.frame = previewLayer.bounds
        darkLayer.backgroundColor = UIColor.black.withAlphaComponent(1).cgColor

        // Cria um caminho para o recorte transparente
        let transparentPath = CGMutablePath()
        transparentPath.addRect(previewLayer.bounds)
        // Define as dimensões do quadrado transparente no meio
        let transparentRect = CGRect(x: previewLayer.bounds.midX - 125, y: previewLayer.bounds.midY - 100, width: 250, height: 200)
        transparentPath.addRect(transparentRect)
        
        // Configura a máscara para tornar o centro transparente
        let maskLayer = CAShapeLayer()
        maskLayer.path = transparentPath
        maskLayer.fillRule = .evenOdd
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.backgroundColor = UIColor.clear.cgColor
        maskLayer.opacity = 0.5
        darkLayer.mask = maskLayer

        // Salva a referência da darkLayer
        self.darkOverlayLayer = darkLayer

        // Adiciona a camada escura com o recorte à previewLayer
        previewLayer.addSublayer(darkLayer)

        // Adiciona a linha vermelha ao quadrado transparente
        let lineLayer = CALayer()
        lineLayer.frame = CGRect(x: transparentRect.minX, y: transparentRect.midY - 1, width: transparentRect.width, height: 2)
        lineLayer.backgroundColor = UIColor.red.cgColor
        previewLayer.addSublayer(lineLayer)

        // Salva a referência da lineLayer
        self.redLineLayer = lineLayer
    }

    
    func removeCameraOverlay() {
        darkOverlayLayer?.removeFromSuperlayer()
        darkOverlayLayer = nil
        redLineLayer?.removeFromSuperlayer()
        redLineLayer = nil
    }

        
}

extension CameraController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //
    }
    
}

extension CameraController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            print("\(stringValue)")
        }
    }
}
