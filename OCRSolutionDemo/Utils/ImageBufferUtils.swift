//
//  ImageBufferUtils.swift
//  OCRSolutionDemo
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit
import AVFoundation

class ImageBufferUtils {
    static func precessImageBuffer(sampleBuffer: CMSampleBuffer, onCompletion: (CGImage?) -> Void) {
        
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            NSLog("Error: cannot read image buffer")
            onCompletion(nil)
            return
        }
        
        CVPixelBufferLockBaseAddress(imageBuffer, .readOnly)
        let width = CVPixelBufferGetWidthOfPlane(imageBuffer, 0)
        let height = CVPixelBufferGetHeightOfPlane(imageBuffer, 0)
        let bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 0)
        let lumaBuffer = CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0)
        let bitMapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        
        let context = CGContext(data: lumaBuffer,
                                width: width,
                                height: height,
                                bitsPerComponent: 8,
                                bytesPerRow: bytesPerRow,
                                space: CGColorSpaceCreateDeviceGray(),
                                bitmapInfo: bitMapInfo.rawValue)
        
        guard let resultImage = context?.makeImage() else {
            NSLog("Error: cannot convert CGContext to CGImage")
            onCompletion(nil)
            return
        }
        
        onCompletion(resultImage)
        CVPixelBufferUnlockBaseAddress(imageBuffer, .readOnly)
    }
}
