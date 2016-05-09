//
//  Draw.swift
//  Project_Final
//
//  Created by haha on 16/4/21.
//  Copyright © 2016年 haha. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    // If we find a device we'll store it here for later use
    var captureDevice : AVCaptureDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        let devices = AVCaptureDevice.devices()
        
        // Loop through all the capture devices on this phone
        for device in devices {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil {
                        print("Capture device found")
                        beginSession()
                    }
                }
            }
        }
        
    }
    
    func focusTo(value : Float) {
        if let device = captureDevice {
            do {
                try device.lockForConfiguration()
                device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
                    //
                })
                device.unlockForConfiguration()
            } catch let error as NSError {
                print(error.code)
            }        }
    }
    let screenWidth = UIScreen.mainScreen().bounds.size.width
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var anyTouch = touches.first
        var touchPercent = anyTouch!.locationInView(self.view).x / screenWidth
        focusTo(Float(touchPercent))
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var anyTouch = touches.first
        var touchPercent = anyTouch!.locationInView(self.view).x / screenWidth

        focusTo(Float(touchPercent))
    }
    
    func configureDevice() {
        if let device = captureDevice {
            do {
                try device.lockForConfiguration()
                device.focusMode = .Locked
                device.unlockForConfiguration()
            }
            catch{
                print("configure error")
            }
        }
        
    }
    
    func beginSession() {
        
        configureDevice()
        
//        var err : NSError? = nil
//        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        let input = try! AVCaptureDeviceInput(device: captureDevice)
        captureSession.addInput(input)
        

        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        self.view.layer.addSublayer(previewLayer!)
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
    }
    
}
