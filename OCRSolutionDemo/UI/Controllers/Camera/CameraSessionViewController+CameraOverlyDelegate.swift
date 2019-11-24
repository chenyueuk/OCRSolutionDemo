//
//  CameraSessionViewController+CameraOverlyDelegate.swift
//  OCRSolutionDemo
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit
import AVFoundation

extension CameraSessionViewController: CameraOverlayDelegate {
    func toggleFlashButton(flashOn: Bool) {
        guard let device = backCamera, device.hasTorch else {
            NSLog("Error: this device does not support flash on")
            return
        }
        do {
            try device.lockForConfiguration()
            device.torchMode = flashOn ? .on : .off
            device.unlockForConfiguration()
        } catch {
            NSLog("Error: error on locking camera flash")
        }
    }
    
    func startScanning() {
        viewModel.shouldProcessBuffer = true
    }
    
    func endScanning() {
        viewModel.shouldProcessBuffer = false
    }
    
    func dismissTapped() {
        dismiss(animated: true, completion: nil)
    }
}
