//
//  CameraSessionTests.swift
//  OCRSolutionDemoTests
//
//  Created by YUE CHEN on 24/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import XCTest
@testable import OCRSolutionDemo

class CameraSessionTests: XCTestCase {

    let cameraSession = CameraSessionViewController(rangeFinderSize: .medium,
                                                    ocrEngine: FirebaseEngine(option: .onDevice))
    
    func testViewModel() {
        XCTAssertEqual(cameraSession.viewModel.rangeFinderSize, .medium)
        XCTAssertEqual(cameraSession.viewModel.shouldProcessBuffer, false)
    }
}
