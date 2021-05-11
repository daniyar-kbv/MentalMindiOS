//
//  PhotoLibraryPermissionManager.swift
//  MentalMindiOS
//
//  Created by Dan on 4/2/21.
//

import Foundation
import Photos
import UIKit

class PhotoLibraryPermissionManager {
    static let status = PHPhotoLibrary.authorizationStatus()
    
    static func isPermitted(completion: @escaping(_ isPermitted: Bool) -> ()) {
        switch status {
        case .authorized, .limited:
            completion(true)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ status in
                switch status {
                case .authorized, .limited:
                    completion(true)
                default:
                    completion(false)
                    showAlert()
                }
            })
        default:
            completion(false)
            showAlert()
        }
    }
    
    private static func showAlert() {
        let alertController = UIAlertController(title: "Photo access not granted title".localized, message: "Photo access not granted message".localized, preferredStyle: .alert)
        
        let firstAction = UIAlertAction(title: "To settings".localized, style: .default, handler: { _ in
            guard let url = URL(string:UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        let secondAction = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        
        alertController.addAction(secondAction)
        alertController.addAction(firstAction)
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
        }
    }
}
