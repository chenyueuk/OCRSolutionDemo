//
//  UtilsTests.swift
//  OCRSolutionDemoTests
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import XCTest
@testable import OCRSolutionDemo

class UtilsTests: XCTestCase {

    let numberPlateImage = UIImage(named: "TestRegistration") ?? UIImage()
    
    func testDefaultFiltering() {
        XCTAssertNotNil(numberPlateImage.defaultImageFilter())
    }
    
    func testIndividualFilters() {
        XCTAssertNotNil(numberPlateImage.imageAdapativeFilter(blurRadius: 1.0))
        XCTAssertNotNil(numberPlateImage.removeNoiseFilter(blurRadius: 1.0))
        XCTAssertNotNil(numberPlateImage.sharpenFilter(sharpness: 1.0))
    }
    
    func testDefaultImageFilter() {
        XCTAssertNotNil(numberPlateImage.defaultImageFilter())
    }

}
