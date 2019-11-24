//
//  OCREngineProtocol.swift
//  OCRSolutionDemo
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit

/*---Share protocol for Tesseract and FirebaseML OCR engines---*/
protocol OCREngineProtocol {
    
    /**
    * Processes the given image for ocr text recognition.
    *
    * @param image The image to process for recognizing text.
    * @param onCompletion handler to call back when text recognition completes.
    */
    func detectTextFromImage(image: UIImage, onCompletion: @escaping(String?) -> Void)
}
