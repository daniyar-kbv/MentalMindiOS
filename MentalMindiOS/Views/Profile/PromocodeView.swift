//
//  PromocodeView.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation
import UIKit
import SnapKit

class PromocodeView: BaseView {
    lazy var topText: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.font = .montserrat(ofSize: StaticSize.size(16), weight: .medium)
        view.textColor = .customTextBlack
        view.text = "Если у Вас есть промокод, введите его ниже, чтобы получить доступ к полному функционалу приложения".localized
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.font = .montserrat(ofSize: StaticSize.size(12), weight: .medium)
        view.textColor = .customTextBlack
        view.text = "Промокод".localized
        return view
    }()
    
    lazy var fieldView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = StaticSize.size(10)
        view.layer.borderWidth = StaticSize.size(1)
        view.layer.borderColor = UIColor.customGray.cgColor
        return view
    }()
    
    lazy var textField: UITextField = {
        let view = UITextField()
        view.font = .montserrat(ofSize: StaticSize.size(18), weight: .regular)
        view.textColor = .customTextBlack
        view.attributedPlaceholder = NSAttributedString(
            string: "Введите промокод".localized,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.customTextGray
            ]
        )
        return view
    }()
    
    lazy var bottomButton: CustomButton = {
        let view = CustomButton()
        view.backgroundColor = .customBlue
        view.setTitle("Отправить".localized, for: .normal)
        view.titleLabel?.font = .montserrat(ofSize: StaticSize.size(17), weight: .medium)
        view.setTitleColor(.white, for: .normal)
        view.isActive = false
        return view
    }()
    
    required init() {
        super.init(titleOnTop: true)
        
        backgroundColor = .white
        barStyle = .darkContent
        
        setUp()
    }
    
    func setUp() {
        contentView.addSubViews([topText, title, fieldView, bottomButton])
        
        topText.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(30))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        title.snp.makeConstraints({
            $0.top.equalTo(topText.snp.bottom).offset(StaticSize.size(20))
            $0.left.equalToSuperview().offset(StaticSize.size(15))
        })
        
        fieldView.snp.makeConstraints({
            $0.top.equalTo(title.snp.bottom).offset(StaticSize.size(6))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
        
        fieldView.addSubview(textField)
        
        textField.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.size(12))
        })
        
        bottomButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.height.equalTo(StaticSize.buttonHeight)
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(titleOnTop: Bool = true) {
        fatalError("init(titleOnTop:) has not been implemented")
    }
}
