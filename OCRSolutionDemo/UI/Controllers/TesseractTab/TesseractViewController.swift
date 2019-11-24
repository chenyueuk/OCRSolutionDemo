//
//  TesseractViewController.swift
//  OcrRegexLib
//
//  Created by YUE CHEN on 22/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit
import TesseractOCR

class TesseractViewController: UIViewController {
    
    var viewModel = TesseractControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    /**
    * Start button event handler for TesseractViewController.
    *
    * @param sender the source button where the event was fired
    */
    @IBAction func startButtonTapped(sender: UIButton?) {
        let cameraVC = CameraSessionViewController(rangeFinderSize: viewModel.rangeFinderSize,
                                                   ocrEngine: viewModel.tesseractEngine())
        cameraVC.modalPresentationStyle = .fullScreen
        present(cameraVC, animated: true, completion: nil)
    }
    
    /**
    * Language text field event handler for TesseractViewController.
    *
    * @param sender the source button where the event was fired
    */
    @IBAction func updateLanguage(sender: UITextField) {
        viewModel.language = sender.text ?? ""
    }
    
    /**
    * White list text field event handler for TesseractViewController.
    *
    * @param sender the source button where the event was fired
    */
    @IBAction func updateWhiteList(sender: UITextField) {
        viewModel.whiteList = sender.text
    }
    
    /**
    * Black list text field event handler for TesseractViewController.
    *
    * @param sender the source button where the event was fired
    */
    @IBAction func updateBlackList(sender: UITextField) {
        viewModel.blackList = sender.text
    }
    
    /**
    * Recognition time text field event handler for TesseractViewController.
    *
    * @param sender the source button where the event was fired
    */
    @IBAction func updateRecognitionTime(sender: UITextField) {
        viewModel.setRecognitionTime(text: sender.text ?? "")
    }
    
    /**
    * Engine mode segmented control event handler for TesseractViewController.
    *
    * @param sender the source button where the event was fired
    */
    @IBAction func updateEngineMode(sender: UISegmentedControl) {
        viewModel.setEngineMode(index: sender.selectedSegmentIndex)
    }
    
    /**
    * Range finder size segmented control event handler for TesseractViewController.
    *
    * @param sender the source button where the event was fired
    */
    @IBAction func updateRangeFinderSize(sender: UISegmentedControl) {
        viewModel.setRangeFinderSize(index: sender.selectedSegmentIndex)
    }
}

