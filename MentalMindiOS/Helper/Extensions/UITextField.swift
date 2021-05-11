//
//  UITextField.swift
//  Samokat
//
//  Created by Daniyar on 7/22/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func isEmpty() -> Bool {
        return self.text?.count == 0
    }
    
    func addButton(view: UIView) -> UIButton {
        let inputButtonView: UIView = {
            let view = UIView()
            return view
        }()

        let nextButton: CustomButton = {
            let view = CustomButton()
            view.isActive = false
            return view
        }()

        view.addSubViews([inputButtonView])

        inputButtonView.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-Global.safeAreaBottom() - StaticSize.size(30))
            $0.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.buttonHeight + StaticSize.size(30))
        })

        inputButtonView.addSubview(nextButton)
        nextButton.snp.makeConstraints({
            $0.edges.equalToSuperview().inset(StaticSize.size(15))
        })
        
        inputAccessoryView = inputButtonView
        return nextButton
    }
}
