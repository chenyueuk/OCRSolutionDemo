//
//  TesseractTests.swift
//  OcrRegexLibTests
//
//  Created by YUE CHEN on 22/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import XCTest
import TesseractOCR
@testable import OCRSolutionDemo

class TesseractTests: XCTestCase {

    var tesseractSettings: TesseractSettings = TesseractSettings()
    let basicImage = UIImage(named: "ToTestOCR") ?? UIImage()
    let numberPlateImage = UIImage(named: "TestRegistration") ?? UIImage()
    
    override func setUp() {
        // set settings to default for every test
        tesseractSettings = TesseractSettings()
    }
    
    func testBaseSettings() {
        XCTAssertEqual(tesseractSettings.engineMode, G8OCREngineMode.tesseractOnly)
        XCTAssertEqual(tesseractSettings.language, "eng")
        XCTAssertEqual(tesseractSettings.recognitionTime, 0.3)
        XCTAssertNil(tesseractSettings.whiteList)
        XCTAssertNil(tesseractSettings.blackList)
    }


    func testUpdateSettings() {
        tesseractSettings.engineMode = .cubeOnly
        tesseractSettings.language = "it"
        tesseractSettings.recognitionTime = 1.8
        tesseractSettings.whiteList = "ABC"
        tesseractSettings.blackList = "DEF"
        
        XCTAssertEqual(tesseractSettings.engineMode, G8OCREngineMode.cubeOnly)
        XCTAssertEqual(tesseractSettings.language, "it")
        XCTAssertEqual(tesseractSettings.recognitionTime, 1.8)
        XCTAssertEqual(tesseractSettings.whiteList, "ABC")
        XCTAssertEqual(tesseractSettings.blackList, "DEF")
    }
    
    func testBaseEngineSettings() {
        let baseEngine = TesseractEngine(with: tesseractSettings)
        XCTAssertEqual(baseEngine.settings.engineMode, G8OCREngineMode.tesseractOnly)
        XCTAssertEqual(baseEngine.settings.language, "eng")
        XCTAssertEqual(baseEngine.settings.recognitionTime, 0.3)
        XCTAssertNil(baseEngine.settings.whiteList)
        XCTAssertNil(baseEngine.settings.blackList)
        
        baseEngine.detectTextFromImage(image: basicImage, onCompletion: { text in
            let result = text ?? ""
            XCTAssertTrue(result.contains("WORDS"))
            XCTAssertTrue(result.contains("MATTER"))
        })
    }
    
    func testWhiteList() {
        tesseractSettings.whiteList = "WORDS"
        let baseEngine = TesseractEngine(with: tesseractSettings)
        baseEngine.detectTextFromImage(image: basicImage, onCompletion: { text in
            let result = text ?? ""
            XCTAssertTrue(result.contains("WORDS"))
            XCTAssertFalse(result.contains("MATTER"))
        })
    }
    
    func testBlackList() {
        tesseractSettings.blackList = "MAT"
        let baseEngine = TesseractEngine(with: tesseractSettings)
        baseEngine.detectTextFromImage(image: basicImage, onCompletion: { text in
            let result = text ?? ""
            XCTAssertTrue(result.contains("WORDS"))
            XCTAssertFalse(result.contains("MATTER"))
        })
    }
    
    func testAdvancedOptions() {
        let baseEngine = TesseractEngine(with: tesseractSettings)
        baseEngine.detectTextFromImage(image: numberPlateImage, onCompletion: { text in
            let result = text ?? ""
            // tesseractOnly engine mode is not powerful enough for the registration plate
            // 8 is recognised as B
            XCTAssertFalse(result.contains("PL8TE"))
            XCTAssertFalse(result.contains("PL8TE"))
        })
        
        tesseractSettings.engineMode = .cubeOnly
        tesseractSettings.recognitionTime = 1.0
        let advancedEngine = TesseractEngine(with: tesseractSettings)
        advancedEngine.detectTextFromImage(image: numberPlateImage, onCompletion: { text in
            let advancedResult = text ?? ""
            XCTAssertTrue(advancedResult.contains("PL8TE"))
        })
    }
    
    func testDefaultFiltersDisabled() {
        let baseEngine = TesseractEngine(with: tesseractSettings)
        let image = baseEngine.preprocessedImage(for: baseEngine.tesseract,
                                                 sourceImage: basicImage)
        XCTAssertEqual(basicImage, image)
    }
}
