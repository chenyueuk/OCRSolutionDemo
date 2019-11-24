//
//  UIImage+Utils.swift
//  OCRSolutionDemo
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit
import EVGPUImage2

extension UIImage {
    static let defaultAdaptiveBlurRadius: Float = 15.0
    static let defaultGaussianBlurRadius: Float = 3.0
    static let defaultSharpness: Float = 4.0
    
    static func createImage(cgImage: CGImage?, size: CameraRangeFinderSize) -> UIImage? {
        guard let cgImage = cgImage else {
            return nil
        }
        let rect: CGRect = CGRect(x: CGFloat(cgImage.width) * size.widthOffset(),
                                  y: CGFloat(cgImage.height) * size.heightOffset(),
                                  width: CGFloat(cgImage.width) * size.widthRatio(),
                                  height: CGFloat(cgImage.height) * size.heightRatio())
        guard let imageRef = cgImage.cropping(to: rect) else {
            return nil
        }
        return UIImage(cgImage: imageRef, scale: 1.0, orientation: .up)
    }
    
    func defaultImageFilter() -> UIImage {
        let adaptive = imageAdapativeFilter(blurRadius: UIImage.defaultAdaptiveBlurRadius)
        let removeNoise = removeNoiseFilter(blurRadius: UIImage.defaultGaussianBlurRadius)
        let sharpen = sharpenFilter(sharpness: UIImage.defaultSharpness)
        return self.filterWithPipeline { (input, output) in
            input --> adaptive --> removeNoise --> sharpen --> output
        }
    }
    
    func imageAdapativeFilter(blurRadius: Float) -> OperationGroup {
        let imageFilter = AdaptiveThreshold()
        imageFilter.blurRadiusInPixels = blurRadius
        return imageFilter
    }
    
    func removeNoiseFilter(blurRadius: Float) -> TwoStageOperation {
        let imageFilter = GaussianBlur()
        imageFilter.blurRadiusInPixels = blurRadius
        return imageFilter
    }
    
    func sharpenFilter(sharpness: Float) -> BasicOperation {
        let imageFilter = Sharpen()
        imageFilter.sharpness = sharpness
        return imageFilter
    }
}
