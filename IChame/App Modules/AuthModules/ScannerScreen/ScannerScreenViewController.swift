//
//  ScannerScreenViewController.swift
//  IChame
//
//  Created by Rezo Joglidze on 3/14/21.
//  Copyright © 2021 Rezo Joglidze. All rights reserved.
//

import UIKit
import XCoordinator
import AVFoundation
import QRCodeReader
import RxSwift

class ScannerScreenViewController: UIViewController {
  
  var viewModel: ScannerScreenViewModelProocol!
  
  @IBOutlet weak var scannerBtn: UIButton!
  private var disposeBag = DisposeBag()
  
  lazy var readerVC: QRCodeReaderViewController = {
    let builder = QRCodeReaderViewControllerBuilder {
      $0.reader                  = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
      $0.showTorchButton         = true
      $0.preferredStatusBarStyle = .lightContent
      $0.showOverlayView         = true
      $0.rectOfInterest          = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
      $0.reader.stopScanningWhenCodeIsFound = false
    }
    return QRCodeReaderViewController(builder: builder)
  }()
  
  static func instantiate(unownedRouter: UnownedRouter<AuthRoute>) -> Self {
    let viewController = ScreensAssembly.shared.container.resolve(Self.self, argument: unownedRouter) ?? .init()
    return viewController
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.isNavigationBarHidden = false
    scannerBtn.setTitle("QR სკანერი".uppercased(), for: .normal)
    setupObservables()
  }
  
  private func setupObservables() {
    viewModel.menuDidLoaded.subscribe(onNext: {
      self.stopLoader()
    }).disposed(by: disposeBag)
  }
  
  @IBAction func scannerBtnTapped(_ sender: AnyObject) {
    self.startLoader()
    
    if !Constants.isNeededQRScanner {
      viewModel.getMenu(docId: Constants.menuId, fail: self.standardFailBlock)
    } else {
      guard checkScanPermissions() else { return }
      readerVC.modalPresentationStyle = .formSheet
      readerVC.delegate               = self
      readerVC.completionBlock = { (result: QRCodeReaderResult?) in
        if let result = result {
          print("menuId: \(result.value)")
        }
      }
      present(readerVC, animated: true, completion: nil)
    }
  }
}

//MARK: QRCodeReaderViewControllerDelegate
extension ScannerScreenViewController: QRCodeReaderViewControllerDelegate {
  func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
    reader.stopScanning()
    dismiss(animated: true) { [weak self] in
      //      let alert = UIAlertController(title: result.value, message: nil, preferredStyle: .alert)
      //      alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      //      self?.present(alert, animated: true, completion: nil)
      guard let self = self else { return }
      self.viewModel.getMenu(docId: result.value, fail: self.standardFailBlock)
    }
  }
  
  func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
    print("Switching capture to: \(newCaptureDevice.device.localizedName)")
  }
  
  func readerDidCancel(_ reader: QRCodeReaderViewController) {
    reader.stopScanning()
    dismiss(animated: true, completion: nil)
  }
}

//MARK: QRSCanner Persmission
extension ScannerScreenViewController {
  private func checkScanPermissions() -> Bool {
    do {
      return try QRCodeReader.supportsMetadataObjectTypes()
    } catch let error as NSError {
      let alert: UIAlertController
      switch error.code {
      case -11852:
        alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
          DispatchQueue.main.async {
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
          }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
      default:
        alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      }
      present(alert, animated: true, completion: nil)
      return false
    }
  }
}
