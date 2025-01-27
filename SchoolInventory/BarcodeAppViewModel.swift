//
//  BarcodeAppViewModel.swift
//  SchoolInventory
//
//  Created by Aneena M. Ginson on 12/13/24.
//
//import AVKit
//import Foundation
//import SwiftUI
//import VisionKit
//
//enum ScanType: String {
//    case text, barcode
//}
//
//enum DataScannerAccessStatusType {
//    case notDetermined
//    case cameraAccessNotGranted
//    case cameraNotAvaliable
//    case scannerAvaliable
//    case scannerNotAvaliable
//}
//@MainActor
//final class BarcodeAppViewModel: ObservableObject {
//    
//    @Published var dataScannerAccessStatus: DataScannerAccessStatusType = .notDetermined
//    @Published var recognizedItems: [RecognizedItem] = []
//    @Published var scanType: ScanType = .barcode
//    @Published var textContentType: DataScannerViewController.TextContentType?
//    @Published var recognizesMultipeItems = true
//    
//    var recognizedDataType: DataScannerViewController.RecognizedDataType {
//        scanType == .barcode ? .barcode() : .text(textContentType: textContentType)
//    }
//    var headerText: String {
//        if recognizedItems.isEmpty {
//            return "Scanning \(scanType.rawValue)"
//        } else {
//            return "Recognized \(recognizedItems.count) item(s)"
//        }
//    }
//    var dataScannerViewerId: Int {
//        var hasher = Hasher()
//        hasher.combine(scanType)
//        hasher.combine(recognizesMultipeItems)
//        if let textContentType {
//            hasher.combine(textContentType)
//        }
//        return hasher.finalize()
//    }
//    private  var isScannerAvaliable : Bool {
//        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
//    }
//    
//    func requestDataScannerAccessStatus() async {
//        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
//            dataScannerAccessStatus = .cameraNotAvaliable
//            return
//        }
//        switch AVCaptureDevice.authorizationStatus(for: .video) {
//            
//        case .authorized:
//            dataScannerAccessStatus = isScannerAvaliable ? .scannerAvaliable : .scannerNotAvaliable
//            
//        case .restricted, .denied:
//            dataScannerAccessStatus = .cameraAccessNotGranted
//            
//        case .notDetermined:
//            let granted = await AVCaptureDevice.requestAccess(for: .video)
//            if granted {
//                dataScannerAccessStatus = isScannerAvaliable ? .scannerAvaliable : .scannerNotAvaliable
//            } else {
//                dataScannerAccessStatus = .cameraAccessNotGranted
//            }
//        default: break
//        }
//    }
//}
//
