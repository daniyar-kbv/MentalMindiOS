//
//  UIViewCOntroller.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

var textViewToClose: UITextView?
fileprivate var excludedViews: [UIView] = []

extension UIViewController {    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func addBackButton(){
        let backImage = UIImage(named: "backButton")!.withRenderingMode(.alwaysOriginal)
        let imageView = UIImageView.init(image: backImage)
        let backView = UIView()
        backView.addSubview(imageView)
        imageView.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.width.equalTo(StaticSize.size(10))
            $0.height.equalTo(StaticSize.size(18))
        })
        let menuItem = UIBarButtonItem(customView: backView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(pop))
        backView.addGestureRecognizer(tapGesture)
        let widthConstraintLeft = backView.widthAnchor.constraint(equalToConstant: 40)
        let heightConstraintLeft = backView.heightAnchor.constraint(equalToConstant: 40)
        heightConstraintLeft.isActive = true
        widthConstraintLeft.isActive = true
        menuItem.imageInsets = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        navigationItem.leftBarButtonItems = [menuItem]
    }
    
    @objc func pop(){
        navigationController?.popViewController(animated: true)
    }
    
    func openTop(vc: UIViewController){
        add(vc)
        
        vc.view.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview().offset(ScreenSize.SCREEN_WIDTH)
            $0.width.equalToSuperview()
        })
        
        view.layoutIfNeeded()
        
        vc.view.snp.updateConstraints({
            $0.left.equalToSuperview()
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func removeTop(){
        view.snp.updateConstraints({
            $0.left.equalToSuperview().offset(ScreenSize.SCREEN_WIDTH)
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            self.view.superview?.layoutIfNeeded()
        }, completion: { finished in
            if finished {
                self.remove()
            }
        })
    }
    
//  MARK: - Keyboard opening
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround(exculdeViews: [UIView] = []) {
        excludedViews = exculdeViews
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardWithExcude(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboardWithExcude(_ sender: UITapGestureRecognizer) {
        let v = sender.view
        let loc = sender.location(in: v)
        let subview = view?.hitTest(loc, with: nil)
        if !excludedViews.contains(subview ?? UIView()) {
            view.endEditing(true)
        }
    }
    
    func hideKeyboardWhenTappedAround(textView: UITextView) {
        textViewToClose = textView
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboardTextView))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboardTextView() {
        textViewToClose?.resignFirstResponder()
    }
    
    func keyboardDisplay(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        let window: UIWindow = Global.keyWindow!
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if window.frame.origin.y == 0
            {
                window.frame.origin.y -= (keyboardSize.height - StaticSize.size(20))
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        let window: UIWindow = Global.keyWindow!
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        {
            if window.frame.origin.y != 0
            {
                window.frame.origin.y += (keyboardSize.height - StaticSize.size(20))
            }
        }
    }
    
    func disableKeyboardDisplay(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func showAlert(title: String?, messsage: String? = nil, actions: [(key: String, value: ((UIAlertAction) -> Void)?)] = [(key: "Ок".localized, value: nil)]) {
        let alertController = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        
        for action in actions {
            alertController.addAction(
                UIAlertAction(title: action.key, style: .default, handler: action.value)
            )
        }
        
        present(alertController, animated: true, completion: nil)
    }
//    }
    
    @objc func dismissAnimated() {
        dismiss(animated: true, completion: nil)
    }
    
    func removeSideSwipe() {
        if let recognizers = self.navigationController?.view.gestureRecognizers{
            var removed = 0
            for i in 0..<recognizers.count{
                if recognizers[i].name != "_UIParallaxTransitionPanGestureRecognizer"{
                    self.navigationController?.view.gestureRecognizers?.remove(at: i - removed)
                    removed += 1
                }
            }
        }
    }
}
