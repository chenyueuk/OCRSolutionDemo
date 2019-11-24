//
//  CameraViewTests.swift
//  OCRSolutionDemoTests
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import XCTest
@testable import OCRSolutionDemo

class CameraDelegateClassMock: UIViewController, CameraOverlayDelegate {
    var flashTapped = false
    var startScanningFired = false
    var endScanningFired = false
    var dismissButtonTapped = false
    
    lazy var overlayView: CameraOverlayView = {
        return CameraOverlayView(rangeFinderSize: .medium, delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(overlayView)
    }
    
    func toggleFlashButton(flashOn: Bool) {
        flashTapped = true
    }
    func startScanning() {
        startScanningFired = true
    }
    func endScanning() {
        endScanningFired = true
    }
    func dismissTapped() {
        dismissButtonTapped = true
    }
}

class CameraViewTests: XCTestCase {
    
    func testRangeFinderSizes() {
        XCTAssertEqual(CameraRangeFinderSize.small.heightRatio(), 0.1)
        XCTAssertEqual(CameraRangeFinderSize.medium.heightRatio(), 0.2)
        XCTAssertEqual(CameraRangeFinderSize.large.heightRatio(), 0.3)
        
        XCTAssertEqual(CameraRangeFinderSize.small.heightOffset(), 0.45)
        XCTAssertEqual(CameraRangeFinderSize.medium.heightOffset(), 0.4)
        XCTAssertEqual(CameraRangeFinderSize.large.heightOffset(), 0.35)
        
        XCTAssertEqual(CameraRangeFinderSize.small.widthRatio(), 0.6)
        XCTAssertEqual(CameraRangeFinderSize.medium.widthRatio(), 0.8)
        XCTAssertEqual(CameraRangeFinderSize.large.widthRatio(), 0.9)
        
        XCTAssertEqual(CameraRangeFinderSize.small.widthOffset(), 0.2)
        XCTAssertEqual(CameraRangeFinderSize.medium.widthOffset(), 0.1)
        XCTAssertEqual(CameraRangeFinderSize.large.widthOffset(), 0.05)
    }

    func testSubViews() {
        let cameraVC = CameraSessionViewController(rangeFinderSize: .medium,
                                                   ocrEngine: FirebaseEngine(option: .onDevice))
        cameraVC.loadView()
        XCTAssertNotNil(cameraVC.overlayView)
        XCTAssertNotNil(cameraVC.overlayView.topBackgroundView)
        XCTAssertNotNil(cameraVC.overlayView.bottomBackgroundView)
        XCTAssertNotNil(cameraVC.overlayView.leftBackgroundView)
        XCTAssertNotNil(cameraVC.overlayView.rightBackgroundView)
        XCTAssertNotNil(cameraVC.overlayView.textPreviewView)
        XCTAssertNotNil(cameraVC.overlayView.buttonsStackView)
        XCTAssertNotNil(cameraVC.overlayView.doneButton)
        XCTAssertNotNil(cameraVC.overlayView.flashButton)
        XCTAssertNotNil(cameraVC.overlayView.scanButton)
        
        XCTAssertEqual(cameraVC.overlayView.textPreviewView.text, "")
        cameraVC.overlayView.updateTextPreview(string: "TestRegistration")
        // UI updates happens on main thread, check updates on main thread as well.
        DispatchQueue.main.async {
            XCTAssertNotNil(cameraVC.overlayView.textPreviewView.text)
        }
        
        XCTAssertFalse(cameraVC.viewModel.shouldProcessBuffer)
        cameraVC.startScanning()
        XCTAssertTrue(cameraVC.viewModel.shouldProcessBuffer)
        cameraVC.endScanning()
        XCTAssertFalse(cameraVC.viewModel.shouldProcessBuffer)
    }
    
    func testButtons() {
        let mockVC = CameraDelegateClassMock()
        mockVC.loadView()
        
        XCTAssertFalse(mockVC.flashTapped)
        XCTAssertFalse(mockVC.dismissButtonTapped)
        XCTAssertFalse(mockVC.endScanningFired)
        XCTAssertFalse(mockVC.startScanningFired)
        
        mockVC.overlayView.flashButton.sendActions(for: .touchUpInside)
        DispatchQueue.main.async {
            XCTAssertTrue(mockVC.flashTapped)
        }
        
        mockVC.overlayView.doneButton.sendActions(for: .touchUpInside)
        DispatchQueue.main.async {
            XCTAssertTrue(mockVC.dismissButtonTapped)
        }
        
        mockVC.overlayView.scanButton.sendActions(for: .touchDown)
        DispatchQueue.main.async {
            XCTAssertTrue(mockVC.startScanningFired)
        }
        
        mockVC.overlayView.scanButton.sendActions(for: .touchUpInside)
        DispatchQueue.main.async {
            XCTAssertTrue(mockVC.endScanningFired)
        }
        
        mockVC.endScanningFired = false
        mockVC.overlayView.scanButton.sendActions(for: .touchUpOutside)
        DispatchQueue.main.async {
            XCTAssertTrue(mockVC.endScanningFired)
        }
    }
}
