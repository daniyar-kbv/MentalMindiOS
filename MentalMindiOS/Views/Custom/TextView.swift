//
//  TextView.swift
//  MentalMindiOS
//
//  Created by Dan on 12/21/20.
//

import Foundation
import UIKit
import SnapKit

class TextView: UITextView, UITextViewDelegate {
    var placeholder: String
    var onChange: (()->())?
    var initialHeight: CGFloat = 0
    var isEmpty = true {
        didSet {
            text = isEmpty ? placeholder : nil
            textColor = isEmpty ? .customTextGray : .customTextBlack 
        }
    }
    
    
    required init(placeholder: String) {
        self.placeholder = placeholder
        
        super.init(frame: .zero, textContainer: .none)
        
        backgroundColor = .clear
        layer.borderColor = UIColor.customTextGray.cgColor
        layer.borderWidth = StaticSize.size(1)
        layer.cornerRadius = StaticSize.size(10)
        text = placeholder
        font = .montserrat(ofSize: StaticSize.size(18), weight: .regular)
        textColor = .customTextGray
        isScrollEnabled = true
        textContainerInset = UIEdgeInsets(top: StaticSize.size(14), left: StaticSize.size(StaticSize.size(12)), bottom: StaticSize.size(14), right: StaticSize.size(12))
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if isEmpty {
            isEmpty = false
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            isEmpty = true
        }
        if let onChange = onChange {
            onChange()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let onChange = onChange {
            onChange()
        }
    }
}
