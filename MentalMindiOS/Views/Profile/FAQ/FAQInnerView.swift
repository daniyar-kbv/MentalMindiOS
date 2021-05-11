//
//  FAQInnerView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 15.12.2020.
//

import Foundation
import UIKit
import SnapKit

class FAQInnerView: UIStackView {
    var faq: FAQ? {
        didSet {
            questionLabel.text = faq?.question
            answerLabel.text = faq?.answer
        }
    }
    
    var isActive = false {
        didSet {
            UIView.animate(withDuration: 0.5, animations: {
                self.arrowImage.image = UIImage(named: self.isActive ? "faqArrowUp" : "faqArrowDown")
                self.answerLabel.isHidden = !self.isActive
            })
        }
    }
    
    lazy var questionLabel: CustomLabelWithoutPadding = {
        let label = CustomLabelWithoutPadding()
        label.font = .montserrat(ofSize: StaticSize.size(16), weight: .semiBold)
        label.textColor = .customTextBlack
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var arrowImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "faqArrowDown")
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var button: TappableButton = {
        let view = TappableButton()
        view.backgroundColor = .white
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return view
    }()
    
    lazy var answerLabel: CustomLabelWithoutPadding = {
        let label = CustomLabelWithoutPadding()
        label.font = .montserrat(ofSize: StaticSize.size(14), weight: .semiBold)
        label.textColor = .customGray
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addArrangedSubViews([button, answerLabel])
        
        axis = .vertical
        distribution = .equalSpacing
        alignment = .fill
        
        setUp()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        button.addSubViews([arrowImage, questionLabel])
        
        arrowImage.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(20))
            $0.right.equalToSuperview()
            $0.width.equalTo(StaticSize.size(15))
            $0.height.equalTo(StaticSize.size(9))
        })
        
        questionLabel.snp.makeConstraints({
            $0.top.bottom.equalToSuperview().inset(StaticSize.size(15))
            $0.left.equalToSuperview()
            $0.right.equalTo(arrowImage.snp.left).offset(-StaticSize.size(15))
        })
    }
    
    @objc func buttonTapped() {
        isActive.toggle()
    }
}
