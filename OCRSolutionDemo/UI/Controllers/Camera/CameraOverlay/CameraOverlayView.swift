//
//  CameraOverlayView.swift
//  OCRSolutionDemo
//
//  Created by YUE CHEN on 23/11/2019.
//  Copyright © 2019 YUE CHEN. All rights reserved.
//

import UIKit

/*---Protocol for Camera overlay button events---*/
protocol CameraOverlayDelegate: class {
    
    /**
    * Toggle camera torch flash on/off, fired when flash button tapped.
    *
    * @param flashOn boolean value for the on/off option.
    */
    func toggleFlashButton(flashOn: Bool)
    
    /**
    * Start scanning process, fired when scanning touched down.
    */
    func startScanning()
    
    /**
    * End scanning process, fired when scanning touched up.
    */
    func endScanning()
    
    /**
    * Fired when done buttone tapped.
    */
    func dismissTapped()
}

class CameraOverlayView: UIView {

    let rangeFinderSize: CameraRangeFinderSize
    weak var delegate: CameraOverlayDelegate?
    
    /*---UIComponents---**/
    lazy var topBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .cameraBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var bottomBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .cameraBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var leftBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .cameraBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var rightBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .cameraBackgroundColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var textPreviewView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.boldSystemFont(ofSize: 16.0)
        return view
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    
    lazy var scanButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Scan"), for: .normal)
        button.setImage(UIImage(named: "ScanActive"), for: .highlighted)
        button.setImage(UIImage(named: "ScanActive"), for: .selected)
        button.addTarget(self, action: #selector(scanButtonTapped), for: .touchDown)
        button.addTarget(self, action: #selector(scanButtonEndTapping), for: .touchUpInside)
        button.addTarget(self, action: #selector(scanButtonEndTapping), for: .touchUpOutside)
        return button
    }()
    
    lazy var flashButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "FlashOff"), for: .normal)
        button.setImage(UIImage(named: "FlashOn"), for: .highlighted)
        button.setImage(UIImage(named: "FlashOn"), for: .selected)
        button.addTarget(self, action: #selector(flashButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "DismissCamera"), for: .normal)
        button.setImage(UIImage(named: "DismissCameraActive"), for: .highlighted)
        button.setImage(UIImage(named: "DismissCameraActive"), for: .selected)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /**
    * Initalizer for the CameraOverlayView.
    *
    * @param rangeFinderSize size of the range finder in the camera overlay.
    * @param delegate of the this overlay view.
    */
    init(rangeFinderSize: CameraRangeFinderSize, delegate: CameraOverlayDelegate) {
        self.rangeFinderSize = rangeFinderSize
        self.delegate = delegate
        super.init(frame: .zero)
        addViews()
        setupUIConstraints()
        setupFilterPreviewUIConstraints()
        setupButtonStackUIConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*---Adding subviews and setup UI constraints---*/
    fileprivate func addViews() {
        addSubview(topBackgroundView)
        addSubview(bottomBackgroundView)
        addSubview(leftBackgroundView)
        addSubview(rightBackgroundView)
        
        topBackgroundView.addSubview(textPreviewView)
        
        bottomBackgroundView.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(flashButton)
        buttonsStackView.addArrangedSubview(UIView())
        buttonsStackView.addArrangedSubview(scanButton)
        buttonsStackView.addArrangedSubview(UIView())
        buttonsStackView.addArrangedSubview(doneButton)
    }
    
    fileprivate func setupUIConstraints() {
        NSLayoutConstraint.activate([
            topBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            topBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBackgroundView.heightAnchor.constraint(equalTo: heightAnchor,
                                                      multiplier: rangeFinderSize.heightOffset()),
            
            bottomBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBackgroundView.heightAnchor.constraint(equalTo: heightAnchor,
                                                         multiplier: rangeFinderSize.heightOffset()),
            
            leftBackgroundView.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor),
            leftBackgroundView.bottomAnchor.constraint(equalTo: bottomBackgroundView.topAnchor),
            leftBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftBackgroundView.widthAnchor.constraint(equalTo: widthAnchor,
                                                      multiplier: rangeFinderSize.widthOffset()),
            
            rightBackgroundView.topAnchor.constraint(equalTo: topBackgroundView.bottomAnchor),
            rightBackgroundView.bottomAnchor.constraint(equalTo: bottomBackgroundView.topAnchor),
            rightBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightBackgroundView.widthAnchor.constraint(equalTo: widthAnchor,
                                                       multiplier: rangeFinderSize.widthOffset()),
        ])
    }
    
    fileprivate func setupFilterPreviewUIConstraints() {
        NSLayoutConstraint.activate([
            textPreviewView.centerXAnchor.constraint(equalTo: topBackgroundView.centerXAnchor),
            textPreviewView.centerYAnchor.constraint(equalTo: topBackgroundView.centerYAnchor),
            textPreviewView.heightAnchor.constraint(equalTo: heightAnchor,
                                                    multiplier: rangeFinderSize.heightRatio()),
            textPreviewView.widthAnchor.constraint(equalTo: widthAnchor,
                                                   multiplier: rangeFinderSize.widthRatio()),
        ])
    }
    
    fileprivate func setupButtonStackUIConstraints() {
        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(equalTo: bottomBackgroundView.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: bottomBackgroundView.centerYAnchor),
            buttonsStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            doneButton.heightAnchor.constraint(equalTo: widthAnchor),
            scanButton.heightAnchor.constraint(equalTo: widthAnchor),
            scanButton.centerXAnchor.constraint(equalTo: buttonsStackView.centerXAnchor),
            flashButton.heightAnchor.constraint(equalTo: widthAnchor),
        ])
    }
    
    /**
    * Update text preview box on Main Thread.
    *
    * @param string to be displayed in the text view
    */
    func updateTextPreview(string: String?) {
        DispatchQueue.main.async {
            self.textPreviewView.text = string
        }
    }
}
