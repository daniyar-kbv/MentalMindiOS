//
//  BaseView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation
import UIKit
import SnapKit

class BaseView: UIView {
    var titleOnTop: Bool
    
    enum BarStyle {
        case lightContent
        case darkContent
    }
    
    var barStyle: BarStyle = .lightContent {
        didSet {
            switch barStyle {
            case .lightContent:
                titleLabel.textColor = .white
                backButton.setBackgroundImage(UIImage(named: "arrowLeftBack"), for: .normal)
            case .darkContent:
                titleLabel.textColor = .customTextBlack
                backButton.setBackgroundImage(UIImage(named: "arrowLeftBackBlack"), for: .normal)
            }
        }
    }
    
    lazy var backButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "arrowLeftBack"), for: .normal)
        view.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(28), weight: .bold)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var rightButton: UIButton = {
        let view = UIButton()
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    required init(titleOnTop: Bool = true) {
        self.titleOnTop = titleOnTop
        
        super.init(frame: .zero)
        
        addSubViews([backButton, rightButton, titleLabel, contentView])
        
        rightButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(Global.safeAreaTop())
            $0.right.equalToSuperview()
            $0.size.equalTo(StaticSize.size(48))
        })

        if titleOnTop {
            backButton.snp.makeConstraints({
                $0.top.equalToSuperview().offset(Global.safeAreaTop())
                $0.left.equalToSuperview()
                $0.size.equalTo(StaticSize.size(48))
            })
            
            titleLabel.snp.makeConstraints({
                $0.centerY.equalTo(backButton)
                $0.left.equalTo(backButton.snp.right).offset(StaticSize.size(2))
                $0.right.equalTo(rightButton.snp.left)
            })
        } else {
            titleLabel.snp.makeConstraints({
                $0.centerY.equalTo(rightButton)
                $0.left.equalToSuperview().inset(StaticSize.size(15))
                $0.right.equalTo(rightButton.snp.left)
            })
        }
        
        contentView.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(StaticSize.size(8))
            $0.left.right.bottom.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backTapped() {
        UIApplication.topViewController()?.navigationController?.popViewController(animated: true)
    }
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }
}

