//
//  CameraSessionViewModel.swift
//  OCRSolutionDemo
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit

struct CameraSessionViewModel {
    
    let ocrEngine: OCREngineProtocol
    
    let rangeFinderSize: CameraRangeFinderSize
    
    /** Should only process output buffer when session running. This camera OCR is a real-time process.  */
    var shouldProcessBuffer: Bool = false
}
