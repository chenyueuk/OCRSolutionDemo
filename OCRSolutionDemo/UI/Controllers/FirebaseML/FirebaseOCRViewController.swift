//
//  FirebaseOCRViewController.swift
//  OCRSolutionDemo
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit

class FirebaseOCRViewController: UIViewController {
    
    var viewModel = FirebaseControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    /**
    * Start button event handler for FirebaseOCRViewController.
    *
    * @param sender the source button where the event was fired
    */
    @IBAction func startTapped(sender: UIButton) {
        let cameraVC = CameraSessionViewController(rangeFinderSize: viewModel.rangeFinderSize,
                                                   ocrEngine: viewModel.firebaseEngine())
        cameraVC.modalPresentationStyle = .fullScreen
        present(cameraVC, animated: true, completion: nil)
    }
    
    /**
    * Engine mode segmented control event handler for FirebaseOCRViewController.
    *
    * @param sender the source button where the event was fired
    */
    @IBAction func updateEngineMode(sender: UISegmentedControl) {
        viewModel.setEngineMode(index: sender.selectedSegmentIndex)
    }
    
    /**
    * Range finder size segmented control event handler for FirebaseOCRViewController.
    *
    * @param sender the source button where the event was fired
    */
    @IBAction func updateRangeFinderSize(sender: UISegmentedControl) {
        viewModel.setRangeFinderSize(index: sender.selectedSegmentIndex)
    }
}
