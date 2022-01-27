//
//  HelpView.swift
//  MentalMindiOS
//
//  Created by Dan on 12/21/20.
//

import Foundation
import UIKit
import SnapKit

class HelpView: BaseView {
    lazy var topLabel: CustomLabelWithoutPadding = {
        let view = CustomLabelWithoutPadding()
        view.font = .montserrat(ofSize: StaticSize.size(12), weight: .medium)
        view.textColor = .customTextBlack
        view.text = "Если у Вас позникли вопросы, жалобы или пожелания напишите нам".localized
        return view
    }()
    
    lazy var textView: TextView = {
        let view = TextView(placeholder: "Введите текст".localized)
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(titleOnTop: Bool = true) {
        fatalError("init(titleOnTop:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([topLabel, textView, bottomButton])
        
        topLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(35))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        textView.snp.makeConstraints({
            $0.top.equalTo(topLabel.snp.bottom).offset(StaticSize.size(3))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.size(271))
        })
        
        bottomButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.height.equalTo(StaticSize.buttonHeight)
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
    }
}
