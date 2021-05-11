//
//  AuthField.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/30/20.
//

import Foundation
import UIKit
import SnapKit

class AuthField: UIStackView {
    
    var type: AuthFieldType
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.font = .montserrat(ofSize: StaticSize.size(14), weight: .regular)
        view.textColor = .customTextGray
        view.text = type.title
        view.numberOfLines = 0
        return view
    }()
    
    lazy var fieldView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = StaticSize.size(10)
        view.layer.borderWidth = StaticSize.size(1)
        view.layer.borderColor = UIColor.customTextGray.cgColor
        return view
    }()
    
    lazy var field: UITextField = {
        let view = UITextField()
        if [.loginEmail, .registerEmail, .restoreEmail].contains(type) {
            view.keyboardType = .emailAddress
        }
        view.isSecureTextEntry = [.loginPassword, .registerPassword, .registerRepeatPassword, .restorePassword, .restoreRepeatPassword].contains(type)
        view.font = .montserrat(ofSize: StaticSize.size(18), weight: .regular)
        view.textColor = .customTextBlack
        view.attributedPlaceholder = NSAttributedString(string: type.placeholder,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        view.autocapitalizationType = .none
        return view
    }()
    
    lazy var eyeButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "eyeOpen"), for: .normal)
        view.addTarget(self, action: #selector(eyeTapped), for: .touchUpInside)
        view.tag = 101
        return view
    }()
    
    var isValid: Bool {
        if field.keyboardType == .emailAddress {
            return field.text?.isValidEmail() ?? false
        } else {
            return !(field.text?.isEmpty ?? true)
        }
    }
    
    required init(type: AuthFieldType) {
        self.type = type
        
        super.init(frame: .zero)
        
        axis = .vertical
        distribution = .equalSpacing
        alignment = .fill
        spacing = StaticSize.size(8)
        
        addArrangedSubViews([title, fieldView])
        
        setUp()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        fieldView.snp.makeConstraints({
            $0.height.equalTo(StaticSize.buttonHeight)
        })
        
        if type == .loginPassword {
            fieldView.addSubViews([eyeButton, field])
            
            eyeButton.snp.makeConstraints({
                $0.right.equalToSuperview().offset(-StaticSize.size(12))
                $0.centerY.equalToSuperview()
                $0.size.equalTo(StaticSize.size(30))
            })
            
            field.snp.makeConstraints({
                $0.top.bottom.equalToSuperview()
                $0.right.equalTo(eyeButton.snp.left).offset(-StaticSize.size(12))
                $0.left.right.equalToSuperview().inset(StaticSize.size(12))
            })
        } else {
            fieldView.addSubViews([field])
            
            field.snp.makeConstraints({
                $0.top.bottom.equalToSuperview()
                $0.left.right.equalToSuperview().inset(StaticSize.size(12))
            })
        }
    }
    
    @objc func eyeTapped() {
        field.isSecureTextEntry = !field.isSecureTextEntry
        eyeButton.setBackgroundImage(UIImage(named: field.isSecureTextEntry ? "eyeOpen" : "eyeClose"), for: .normal)
    }
}
