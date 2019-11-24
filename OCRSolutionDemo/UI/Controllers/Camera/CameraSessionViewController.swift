//
//  CameraSessionViewController.swift
//  OCRSolutionDemo
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit
import AVFoundation

class CameraSessionViewController: UIViewController {
    
    var viewModel: CameraSessionViewModel
    
    /*---Camera overlay---*/
    lazy var overlayView: CameraOverlayView = {
        let cameraView = CameraOverlayView(rangeFinderSize: viewModel.rangeFinderSize, delegate: self)
        cameraView.translatesAutoresizingMaskIntoConstraints = false
        return cameraView
    }()
    
    /*---Camera preview---*/
    lazy var previewView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /*---Session variables---*/
    internal var session: AVCaptureSession = AVCaptureSession()
    internal var videoDataOutput: AVCaptureVideoDataOutput = AVCaptureVideoDataOutput()
    internal var backCamera: AVCaptureDevice? = AVCaptureDevice.default(for: .video)
    internal var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    
    /**
    * Initializer for CameraSessionViewController.
    *
    * @param rangeFinderSize for the camera overlay.
    * @param ocrEngine to handler OCR text recognition.
    */
    init(rangeFinderSize: CameraRangeFinderSize, ocrEngine: OCREngineProtocol) {
        self.viewModel = CameraSessionViewModel(ocrEngine: ocrEngine, rangeFinderSize: rangeFinderSize)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*---UI life cycles---*/
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(previewView)
        view.addSubview(overlayView)
        updateUIConstraints()
    }
    
    /**iPads and iPhones are using different Camera resolution*/
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UIDevice.current.userInterfaceIdiom == .pad {
            session.sessionPreset = AVCaptureSession.Preset.photo
        } else {
            session.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        }
        
    }
    
    /**Session preview can be only setup after layout subviews when using autolayout constraints*/
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !session.isRunning {
            setupSession()
            session.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        session.stopRunning()
        toggleFlashButton(flashOn: false)
        super.viewWillAppear(animated)
    }
    
    fileprivate func updateUIConstraints() {
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            previewView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            previewView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            previewView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            previewView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    /*---Session setup---*/
    
    fileprivate func setupSession() {
        setupInput()
    }
    
    fileprivate func setupInput() {
        guard let camera = backCamera,
            let input = try? AVCaptureDeviceInput(device: camera),
            session.canAddInput(input) else {
            return
        }
        session.addInput(input)
        setupOutput()
    }
    
    fileprivate func setupOutput() {
        let cameraQueue = DispatchQueue(label: "CameraQueue")
        videoDataOutput.setSampleBufferDelegate(self, queue: cameraQueue)
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        
        guard session.canAddOutput(videoDataOutput) else {
            NSLog("Error: Cannot setup camera output")
            return
        }
        session.addOutput(videoDataOutput)
        setupPreview()
    }
    
    fileprivate func setupPreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session)
        videoPreviewLayer?.videoGravity = .resizeAspectFill
        videoPreviewLayer?.connection?.videoOrientation = .portrait
        videoPreviewLayer?.frame = previewView.bounds
        
        guard let previewLayer = videoPreviewLayer else {
            NSLog("Error: Cannot setup video preview")
            return
        }
        previewView.layer.addSublayer(previewLayer)
    }
}
