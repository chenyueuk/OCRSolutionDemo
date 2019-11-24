//
//  TesseractEngine.swift
//  OcrRegexLib
//
//  Created by YUE CHEN on 22/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import Foundation
import TesseractOCR

class TesseractEngine: NSObject, G8TesseractDelegate, OCREngineProtocol {

    var tesseract: G8Tesseract
    var settings: TesseractSettings
    
    /**
    * Initialize the Tesseract OCR engine.
    *
    * @param settings to configure the Tesseract OCR engine.
    */
    init(with settings: TesseractSettings) {
        tesseract = G8Tesseract()
        self.settings = settings
        super.init()
        
        tesseract.language = settings.language
        tesseract.engineMode = settings.engineMode
        tesseract.charWhitelist = settings.whiteList
        tesseract.charBlacklist = settings.blackList
        tesseract.maximumRecognitionTime = settings.recognitionTime
        tesseract.delegate = self
    }
    
    /**
    * Default image processing for Tesseract, this implementation will ignore the default Tesseract filters.
    *
    * @param tesseract used for this engine.
    * @param sourceImage before default filtering.
    */
    func preprocessedImage(for tesseract: G8Tesseract, sourceImage: UIImage) -> UIImage? {
        return sourceImage
    }
    
    /**
    * Processes the given image for ocr text recognition.
    *
    * @param image The image to process for recognizing text.
    * @param onCompletion handler to call back when text recognition completes.
    */
    func detectTextFromImage(image: UIImage, onCompletion: @escaping(String?) -> Void) {
        tesseract.image = image
        tesseract.recognize()
        G8Tesseract.clearCache()
        onCompletion(tesseract.recognizedText)
    }
}
