//
//  TesseractControllerViewModel.swift
//  OCRSolutionDemo
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import Foundation
import TesseractOCR

struct TesseractControllerViewModel {
    var language: String = "eng"
    var recognitionTime: Double = 0.5
    var whiteList: String?
    var blackList: String?
    var engineMode: G8OCREngineMode = .tesseractOnly
    var rangeFinderSize: CameraRangeFinderSize = .medium
    
    /**
    * Set the engine mode based on index of segmented control, 0 = tessOnly, 1 = combined, 2 = cubeOnly
    *
    * @param index of the segmented control
    */
    mutating func setEngineMode(index: Int) {
        switch index {
        case 0: engineMode = .tesseractOnly
        case 1: engineMode = .tesseractCubeCombined
        case 2: engineMode = .cubeOnly
        default:
            break
        }
    }
    
    /**
    * Set the range finder size based on index of segmented control, 0 = small, 1 = medium, 2 = large
    *
    * @param index of the segmented control
    */
    mutating func setRangeFinderSize(index: Int) {
        rangeFinderSize = CameraRangeFinderSize(rawValue: index) ?? .medium
    }
    
    /**
    * Set the recognition time with text input, set to default value with invalid input
    *
    * @param text string input for the recognition time
    */
    mutating func setRecognitionTime(text: String) {
        recognitionTime = Double(text) ?? 0.5
    }
    
    /**
    * Create OCR engine based on the settings in this view model
    *
    * @return OCR engine from the settings
    */
    func tesseractEngine() -> TesseractEngine {
        var settings = TesseractSettings()
        settings.language = language
        settings.recognitionTime = recognitionTime
        settings.engineMode = engineMode
        settings.blackList = blackList
        settings.whiteList = whiteList
        return TesseractEngine(with: settings)
    }
}
