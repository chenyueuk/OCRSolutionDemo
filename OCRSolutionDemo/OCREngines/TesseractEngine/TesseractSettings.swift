//
//  TesseractSettings.swift
//  OcrRegexLib
//
//  Created by YUE CHEN on 22/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import Foundation
import TesseractOCR

struct TesseractSettings {
    // Tesseract engineMode, default tesseract is fastest, least accuract
    // cube only is slowest, most accuracte, combined is in between
    var engineMode: G8OCREngineMode = .tesseractOnly
    
    // Default to English, tesseract iOS does not support multi-languages
    var language: String = "eng"
    
    // Max calculation time for TesseractEngine to return result, default 0.3 sec
    // Increase value to give higher accuracy
    var recognitionTime: Double = 0.3
    
    // White list characters
    var whiteList: String?
    
    // Black list characters
    var blackList: String?
}
