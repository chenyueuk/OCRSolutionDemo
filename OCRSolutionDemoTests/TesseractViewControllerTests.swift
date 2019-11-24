//
//  TesseractViewControllerTests.swift
//  OCRSolutionDemoTests
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import XCTest
import TesseractOCR
@testable import OCRSolutionDemo

class TesseractViewControllerTests: XCTestCase {

    let tesserVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TesseractViewController") as? TesseractViewController
    
    override func setUp() {
        tesserVC?.loadView()
    }

    func testViewModel() {
        XCTAssertEqual(tesserVC?.viewModel.language, "eng")
        XCTAssertEqual(tesserVC?.viewModel.recognitionTime, Double(0.5))
        XCTAssertEqual(tesserVC?.viewModel.whiteList, nil)
        XCTAssertEqual(tesserVC?.viewModel.blackList, nil)
        XCTAssertEqual(tesserVC?.viewModel.engineMode, .tesseractOnly)
        XCTAssertEqual(tesserVC?.viewModel.rangeFinderSize, .medium)
        
        tesserVC?.viewModel.setEngineMode(index: 1)
        tesserVC?.viewModel.setRecognitionTime(text: "0.3")
        tesserVC?.viewModel.setRangeFinderSize(index: 0)
        XCTAssertEqual(tesserVC?.viewModel.recognitionTime, Double(0.3))
        XCTAssertEqual(tesserVC?.viewModel.engineMode, .tesseractCubeCombined)
        XCTAssertEqual(tesserVC?.viewModel.rangeFinderSize, .small)
    }
    
    func testCreateSettings() {
        let engine = tesserVC?.viewModel.tesseractEngine()
        XCTAssertNotNil(engine)
    }
}
