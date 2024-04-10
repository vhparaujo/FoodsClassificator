//
//  CameraController.swift
//  FoodsClassificator
//
//  Created by Arthur Dos Reis on 26/03/24.
//

import AVFoundation
import UIKit
import Vision

class CameraController: NSObject, ObservableObject{
    
    var captureSession: AVCaptureSession?
        private let metadataOutput = AVCaptureMetadataOutput()
        private let videoOutput = AVCaptureVideoDataOutput()
        private var previewLayer: AVCaptureVideoPreviewLayer?
        private var photoOutput = AVCapturePhotoOutput()
        private var backCamera: AVCaptureDevice?
        @Published var isStatusBarHidden = false
        private let modelControl = ImagePredictor()


    private var darkOverlayLayer: CALayer?
    private var redLineLayer: CALayer?

    
    override init(){
        super.init()
        setupCaptureSession()
    }
    
    //MARK: - Configuração camera
    func setupCaptureSession(){
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .hd1280x720
        
//        videoOutput.videoSettings = [
//            String(kCVPixelBufferPixelFormatTypeKey): kCVPixelFormatType_32BGRA
//        ]
        
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
            if captureSession?.canAddOutput(photoOutput) == true {
                captureSession?.addOutput(photoOutput) // Adicionando a saída de foto à sessão de captura
            }
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
    
    //MARK: - Tirar foto
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
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
//
}

extension CameraController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData)?.corrigirOrientacao(),
              let cgImage = image.cgImage else { return }
        
        // Convertendo UIImage para CVPixelBuffer
        guard let pixelBuffer = cgImage.toCVPixelBuffer() else { return }
        
        // A detecção de objetos é feita aqui
        modelControl.detectObjects(in: pixelBuffer) { [weak self] results in
            
            // Extrair e imprimir os resultados
            self?.printDetectionResults(results)
            
        }
    }

    private func printDetectionResults(_ results: [VNRecognizedObjectObservation]) {
        print("-----------------")
        for result in results {
            for label in result.labels where label.confidence > 0.5 {
                print("Detecção: \(label.identifier), Confiança: \(label.confidence)")
            }
        }
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

extension CGImage {
    func toCVPixelBuffer() -> CVPixelBuffer? {
        let frameSize = CGSize(width: self.width, height: self.height)
        var pixelBuffer: CVPixelBuffer? = nil
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(frameSize.width), Int(frameSize.height), kCVPixelFormatType_32ARGB, nil, &pixelBuffer)
        if status != kCVReturnSuccess {
            return nil
        }

        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let data = CVPixelBufferGetBaseAddress(pixelBuffer!)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: data, width: Int(frameSize.width), height: Int(frameSize.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.draw(self, in: CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height))
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
}

extension UIImage {
    func corrigirOrientacao() -> UIImage? {
        guard imageOrientation != .up else { return self } // A orientação já está correta

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: .zero, size: size))
        let imagemNormalizada = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return imagemNormalizada
    }
}
