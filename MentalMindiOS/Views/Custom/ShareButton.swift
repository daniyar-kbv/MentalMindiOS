//
//  ShareButton.swift
//  MentalMindiOS
//
//  Created by Dan on 12/24/20.
//

import Foundation
import UIKit
import LinkPresentation

class ShareButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setBackgroundImage(UIImage(named: "shareSquare"), for: .normal)
        
        addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
    }
    
    @objc func shareTapped() {
        guard let img = viewContainingController()?.view.asImage() else { return }
        let image = ImageActivityItemSource(image: img)
        let url = OptionalTextActivityItemSource(text: "https://mentalmind.kz")
        let shareItems = [image, url]
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        viewContainingController()?.present(activityViewController, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShareButton {
    class OptionalTextActivityItemSource: NSObject, UIActivityItemSource {
        let text: String
        weak var viewController: UIViewController?
        
        init(text: String) {
            self.text = text
        }
        
        func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
            return text
        }
        
        func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
            if activityType?.rawValue == "net.whatsapp.WhatsApp.ShareExtension" {
                let alertedAboutWhatsAppDefaultsKey = "DidAlertAboutWhatsAppLimitation"
                if !UserDefaults.standard.bool(forKey: alertedAboutWhatsAppDefaultsKey) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                        guard let presentedViewController = activityViewController.presentedViewController else { return }
                        UserDefaults.standard.set(true, forKey: alertedAboutWhatsAppDefaultsKey)
                        
                        let alert = UIAlertController(title: "WhatsApp Doesn't Support Text + Image".localized, message: "Unfortunately WhatsApp doesn’t support sharing both text and an image at the same time. As a result, only the image will be shared.".localized, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ок".localized, style: .cancel, handler: nil))
                        presentedViewController.present(alert, animated: true, completion: nil)
                    }
                }
                
                return nil
            } else {
                return text
            }
        }
    }

    class ImageActivityItemSource: NSObject, UIActivityItemSource {
        let image: UIImage
        
        init(image: UIImage) {
            self.image = image
        }
        
        func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
            return image
        }
        
        func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
            return image
        }
        
        @available(iOS 13.0, *)
        func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
            guard let resourcePath = Bundle.main.resourcePath else { return nil }
            let metadata = LPLinkMetadata()
            let imgName = "AppIcon"
            let path = resourcePath + "/" + imgName
            let urlOfImageToShare = URL(string: path)
            metadata.title = "MentalMind"
            metadata.iconProvider = NSItemProvider.init(contentsOf: urlOfImageToShare)
            return metadata
        }
    }
}
