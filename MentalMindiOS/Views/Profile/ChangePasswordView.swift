//
//  ChangePasswordView.swift
//  MentalMindiOS
//
//  Created by Dan on 12/21/20.
//

import Foundation
import UIKit
import SnapKit

class ChangePasswordView: BaseView {
    lazy var oldPawwordView: PasswordView = {
        let view = PasswordView(type: .oldPassword)
        return view
    }()
    
    lazy var newPawwordView: PasswordView = {
        let view = PasswordView(type: .newPassword)
        return view
    }()
    
    lazy var repeatPawwordView: PasswordView = {
        let view = PasswordView(type: .repeatPassword)
        return view
    }()
    
    lazy var bottomButton: CustomButton = {
        let view = CustomButton()
        view.backgroundColor = .customBlue
        view.setTitle("Сохранить пароль".localized, for: .normal)
        view.titleLabel?.font = .montserrat(ofSize: StaticSize.size(17), weight: .medium)
        view.setTitleColor(.white, for: .normal)
        view.isActive = false
        return view
    }()
    
    required init() {
        super.init(titleOnTop: true)
        
        barStyle = .darkContent
        backgroundColor = .white
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(titleOnTop: Bool = true) {
        fatalError("init(titleOnTop:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([oldPawwordView, newPawwordView, repeatPawwordView, bottomButton])
        
        oldPawwordView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(34))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        newPawwordView.snp.makeConstraints({
            $0.top.equalTo(oldPawwordView.snp.bottom).offset(StaticSize.size(40))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        repeatPawwordView.snp.makeConstraints({
            $0.top.equalTo(newPawwordView.snp.bottom).offset(StaticSize.size(10))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        bottomButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.height.equalTo(StaticSize.buttonHeight)
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
    }
}

class PasswordView: AuthField {
    var viewType: ViewType
    
    required init(type: ViewType) {
        self.viewType = type
        
        super.init(type: .loginPassword)
        
        title.text = viewType.title
        fieldView.layer.borderColor = UIColor.customTextBlack.cgColor
        field.textColor = .customTextBlue
        field.placeholder = ""
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(type: AuthFieldType) {
        fatalError("init(type:) has not been implemented")
    }
    
    enum ViewType {
        case oldPassword
        case newPassword
        case repeatPassword
        
        var title: String {
            switch self {
            case .oldPassword:
                return "Введите текущий пароль".localized
            case .newPassword:
                return "Придумайте новый пароль".localized
            case .repeatPassword:
                return "Повторите новый пароль".localized
            }
        }
    }
}
