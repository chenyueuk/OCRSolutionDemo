//
//  FirebaseEngine.swift
//  OCRSolutionDemo
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import Foundation
import Firebase

class FirebaseEngine: OCREngineProtocol {
    
    enum RecognizerOption {
        case onDevice, cloud
    }
    
    let vision = Vision.vision()
    let textRecognizer: VisionTextRecognizer
    
    /**
    * Initialize the FirebaseML OCR engine.
    *
    * @param option whether engine should use onDevice model or cloud Vision API.
    */
    init(option: RecognizerOption) {
        switch option {
        case .onDevice: textRecognizer = vision.onDeviceTextRecognizer()
        case .cloud: textRecognizer = vision.cloudTextRecognizer()
        }
    }
    
    /**
    * Processes the given image for ocr text recognition.
    *
    * @param image The image to process for recognizing text.
    * @param onCompletion handler to call back when text recognition completes.
    */
    func detectTextFromImage(image: UIImage, onCompletion: @escaping(String?) -> Void) {
        let visionImage = VisionImage(image: image)
        textRecognizer.process(visionImage) { result, error in
            guard error == nil else {
                NSLog("Error: detecting text from image")
                onCompletion(nil)
                return
            }
            onCompletion(result?.text)
        }
    }
    
}
