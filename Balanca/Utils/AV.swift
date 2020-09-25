//
//  AV.swift
//  Diometro
//
//  Created by Vitor Krau on 24/09/20.
//

import AVFoundation
import UIKit
import SwiftUI

class AVFoundationImplementation: UIViewController, ObservableObject {
    static var instance = AVFoundationImplementation()
    var captureSession: AVCaptureSession?
    var rearCamera: AVCaptureDevice?
    var rearCameraInput: AVCaptureDeviceInput?
    var videoPreviewOutput: AVCaptureVideoDataOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var photoOutput: AVCapturePhotoOutput?
    var resizedImage: UIImage?
    var delegate: AVCapturePhotoCaptureDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func didTapRecord() {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: delegate!)
    }
    
    
    
    func setup(){
        self.captureSession = AVCaptureSession()
        let session = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)

        self.rearCamera = session.devices.first
        if let rearCamera = self.rearCamera {
            try? rearCamera.lockForConfiguration()
            rearCamera.focusMode = .continuousAutoFocus
            rearCamera.unlockForConfiguration()
            self.rearCameraInput = try? AVCaptureDeviceInput(device: rearCamera)
            
            if let rearCameraInput = rearCameraInput{
                // always make sure the AVCaptureSession can accept the selected input
                if ((captureSession?.canAddInput(rearCameraInput)) != nil) {
                // add the input to the current session
                captureSession?.addInput(rearCameraInput)
                }
            }
        }
        
        if let captureSession = captureSession {
            // create the preview layer with the configuration you want
            self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            self.videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.videoPreviewLayer?.connection?.videoOrientation = .portrait

            // then add the layer to your current view
            view.layer.insertSublayer(self.videoPreviewLayer!, at: 0)
            self.videoPreviewLayer?.frame = self.view.frame
            self.videoPreviewOutput = AVCaptureVideoDataOutput()
            
            // always make sure the AVCaptureSession can accept the selected output
            if captureSession.canAddOutput(self.videoPreviewOutput!) {
              // add the output to the current session
                captureSession.addOutput(self.videoPreviewOutput!)
            }
        
        }
        self.captureSession?.startRunning()
        
    }

}
