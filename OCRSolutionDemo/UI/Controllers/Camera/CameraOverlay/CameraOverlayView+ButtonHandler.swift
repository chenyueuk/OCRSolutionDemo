//
//  CameraOverlayView+ButtonHandler.swift
//  OCRSolutionDemo
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit

extension CameraOverlayView {
    
    /**
    * Flash button event handler for CameraOverlayView.
    *
    * @param sender the source button where the event was fired
    */
    @objc func flashButtonTapped(sender: UIButton) {
        flashButton.isSelected = !flashButton.isSelected
        delegate?.toggleFlashButton(flashOn: flashButton.isSelected)
    }
    
    /**
    * Done button event handler for CameraOverlayView.
    *
    * @param sender the source button where the event was fired
    */
    @objc func doneButtonTapped(sender: UIButton) {
        delegate?.dismissTapped()
    }
    
    /**
    * Scan button event handler for CameraOverlayView.
    *
    * @param sender the source button where the event was fired
    */
    @objc func scanButtonTapped(sender: UIButton) {
        delegate?.startScanning()
    }
    
    /**
    * Scan button event handler for CameraOverlayView.
    *
    * @param sender the source button where the event was fired
    */
    @objc func scanButtonEndTapping(sender: UIButton) {
        delegate?.endScanning()
    }
}
