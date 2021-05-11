//
//  CustomLabel.swift
//  Samokat
//
//  Created by Daniyar on 7/8/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

class CustomLabel: UITextView {
    var onTap: (()->())?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        isSelectable = false
        isScrollEnabled = false
        isEditable = false
        backgroundColor = .clear
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func tap() {
        if let onTap = onTap{
            onTap()
        }
    }
}

class CustomLabelWithoutPadding: CustomLabel{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        textContainerInset = .zero
        textContainer.lineFragmentPadding = 0
        contentInset = .zero
    }
}
