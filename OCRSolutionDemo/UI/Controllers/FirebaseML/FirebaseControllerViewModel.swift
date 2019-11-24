//
//  FirebaseControllerViewModel.swift
//  OCRSolutionDemo
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import Foundation

struct FirebaseControllerViewModel {
    var engineMode: FirebaseEngine.RecognizerOption = .onDevice
    var rangeFinderSize: CameraRangeFinderSize = .medium
    
    /**
    * Set the engine mode based on index of segmented control, 0 = onDevice, 1 = cloud
    *
    * @param index of the segmented control
    */
    mutating func setEngineMode(index: Int) {
        switch index {
        case 0: engineMode = .onDevice
        case 1: engineMode = .cloud
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
    * Create OCR engine based on the settings in this view model
    *
    * @return OCR engine from the settings
    */
    func firebaseEngine() -> FirebaseEngine {
        return FirebaseEngine(option: engineMode)
    }
}
