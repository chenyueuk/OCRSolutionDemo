//
//  FirebaseTests.swift
//  OCRSolutionDemoTests
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import XCTest
@testable import OCRSolutionDemo

class FirebaseTests: XCTestCase {

    let basicImage = UIImage(named: "ToTestOCR") ?? UIImage()
    let numberPlateImage = UIImage(named: "TestRegistration") ?? UIImage()
    
    func testOnDeviceEngine() {
        let engine = FirebaseEngine(option: .onDevice)
        engine.detectTextFromImage(image: basicImage, onCompletion: { string in
            XCTAssertTrue(string?.contains("WORDS") ?? false)
            XCTAssertTrue(string?.contains("MATTER") ?? false)
        })
        engine.detectTextFromImage(image: numberPlateImage, onCompletion: { string in
            XCTAssertTrue(string?.contains("UK PL8TE") ?? false)
        })
    }
    
    func testCloudEngine() {
        let engine = FirebaseEngine(option: .cloud)
        engine.detectTextFromImage(image: basicImage, onCompletion: { string in
            XCTAssertTrue(string?.contains("WORDS") ?? false)
            XCTAssertTrue(string?.contains("MATTER") ?? false)
        })
        engine.detectTextFromImage(image: numberPlateImage, onCompletion: { string in
            XCTAssertTrue(string?.contains("UK PL8TE") ?? false)
        })
    }


}
