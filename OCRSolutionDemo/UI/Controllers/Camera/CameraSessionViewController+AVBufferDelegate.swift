//
//  CameraSessionViewController+AVBufferDelegate.swift
//  OCRSolutionDemo
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import AVFoundation
import UIKit

extension CameraSessionViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    /**
    * Camera session output buffer handling method.
    *
    * @param output AVCaptureOutput used in this session.
    * @param sampleBuffer CMSampleBuffer from the output session.
    * @param connection current AVCaptureConnection in this session.
    */
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        
        /*In this solution, video orientation is set to portrait.
         output does not have any orientation information, set it to correct output image*/
        connection.videoOrientation = .portrait
        
        // Only process buffer when idle, 'shouldProcessBuffer' is a lock for process
        if viewModel.shouldProcessBuffer {
            // set flag to false while one of the buffer is under processing
            viewModel.shouldProcessBuffer = false
            /* process buffer with image util tools
             Weakify self to avoid memory leak, the process result may be calculated after the parent disposed*/
            ImageBufferUtils.precessImageBuffer(sampleBuffer: sampleBuffer, onCompletion: { [weak self] image in
                if  let size = self?.viewModel.rangeFinderSize,
                    let uiImage = UIImage.createImage(cgImage: image, size: size) {
                    self?.viewModel.ocrEngine.detectTextFromImage(image: uiImage, onCompletion: { text in
                        self?.overlayView.updateTextPreview(string: text)
                        DispatchQueue.main.async {
                            // set flag according to the button state after imageHandling
                            self?.viewModel.shouldProcessBuffer = self?.overlayView.scanButton.isHighlighted ?? false
                        }
                    })
                } else {
                    self?.viewModel.shouldProcessBuffer = true
                }
            })
        }
    }
}
