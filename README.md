# OCRSolutionDemo

## Abstract
This is a demo project for comparing the performance of Tesseract and FirebaseML OCR libraries. This is a real-time process application, the OCR recognition result is detected from camera session.

## Requriement
Device: Please run the app on a iOS device with back camera, which can be iPad, iPod or iPhones
iOS version: 13.2 or above

## Install
This project uses cocoapods to manage the dependencies, make sure to run 'pod install' before using the project

## OCR libraries

### TesseractOCRiOS
Tesseract OCR is one of the oldest and most famous open source OCR libraries. It was written in C/C++ on PC platforms. Daniele Galiotto created the Tesseract OCR wrapper for iOS platform. This project uses his open source library [TesseractOCRiOS](https://github.com/gali8/Tesseract-OCR-iOS)

### FirebaseML OCR
FirebaseML is a mobile SDK that brings Google's machine learning expertise to Android and iOS apps in a powerful yet easy-to-use package. [reference](https://firebase.google.com/docs/ml-kit)

## GPUImage
The OCR is a heavy CPU consuming process. The default filters provided by OCR libraries are using OpenCV filters which may cause significant performance issues. This project uses GPU powered library to do the preprocessing of OCR image.

[GPUImage](https://github.com/BradLarson/GPUImage2) is a library which uses Vision and Metal frameworks and provides high performance filtering on the images.

## License
This project is using MIT license.

