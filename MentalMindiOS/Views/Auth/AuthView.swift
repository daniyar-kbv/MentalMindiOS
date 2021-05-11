//
//  AuthView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/30/20.
//

import Foundation
import UIKit
import SnapKit

class AuthView: AuthBaseView {
    var type: AuthViewType
    
    lazy var mainStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = StaticSize.size(12)
        return view
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let view = UIButton()
        view.setTitle("Забыли пароль?".localized, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.setTitleColor(.customTextGray, for: .highlighted)
        view.titleLabel?.font = .montserrat(ofSize: StaticSize.size(14), weight: .regular)
        view.contentHorizontalAlignment = .right
        return view
    }()
    
    lazy var button: CustomButton = {
        let view = CustomButton()
        view.setTitle(type.buttonTitle, for: .normal)
        view.isActive = false
        return view
    }()
    
    required init(type: AuthViewType) {
        self.type = type
        
        super.init(titleOnTop: type.titleOnTop)
        
        setTitle(type.title)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(titleOnTop: Bool = true) {
        fatalError("init(titleOnTop:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([mainStack, button])
        
        mainStack.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(28))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        button.snp.makeConstraints({
            $0.top.equalTo(mainStack.snp.bottom).offset(StaticSize.size(
                type == .login ?
                    74 :
                    48
            ))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
        
        mainStack.addArrangedSubViews(type.fieldTypes.map({
            AuthField(type: $0)
        }))
        
        if type == .login {
            contentView.addSubViews([forgotPasswordButton])
            
            forgotPasswordButton.snp.makeConstraints({
                $0.top.equalTo(mainStack.snp.bottom).offset(StaticSize.size(5))
                $0.right.equalToSuperview().offset(-StaticSize.size(12))
            })
        }
    }
}


