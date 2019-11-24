//
//  CameraRangeFinderSettings.swift
//  OCRSolutionDemo
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit

enum CameraRangeFinderSize: Int {
    case small, medium, large
    
    /**
    * height ratio to the parent view, scaling 0 to 1
    */
    func heightRatio() -> CGFloat {
        switch self {
        case .small: return 0.1
        case .medium: return 0.2
        case .large: return 0.3
        }
    }
    
    /**
    * width ratio to the parent view, scaling 0 to 1
    */
    func widthRatio() -> CGFloat {
        switch self {
        case .small: return 0.6
        case .medium: return 0.8
        case .large: return 0.9
        }
    }
    
    /**
    * height of shadow area out of range finder, keep 2 decimal points
    */
    func heightOffset() -> CGFloat {
        return ((1 - heightRatio())/2*100).rounded()/100
    }
    
    /**
    * width of shadow area out of range finder, keep 2 decimal points
    */
    func widthOffset() -> CGFloat {
        return ((1 - widthRatio())/2*100).rounded()/100
    }
}
