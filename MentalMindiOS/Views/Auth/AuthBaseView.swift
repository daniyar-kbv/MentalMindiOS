//
//  AuthBaseView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/29/20.
//

import Foundation
import UIKit
import SnapKit

class AuthBaseView: UIView {
    var titleOnTop: Bool
    
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
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    var bottomButton: UIButton = {
        let view = UIButton()
        view.setTitle("У Вас нет аккаунта? Зарегистрируйтесь".localized, for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.setTitleColor(.customTextGray, for: .highlighted)
        view.titleLabel?.font = .montserrat(ofSize: StaticSize.size(14), weight: .regular)
        view.isHidden = true
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addGradientBackground()
    }
    
    required init(titleOnTop: Bool = true) {
        self.titleOnTop = titleOnTop
        
        super.init(frame: .zero)
        
        addSubViews([backButton, titleLabel, contentView, bottomButton])
        
        backButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(Global.safeAreaTop())
            $0.left.equalToSuperview()
            $0.size.equalTo(StaticSize.size(48))
        })
        
        titleOnTop ?
            titleLabel.snp.makeConstraints({
                $0.centerY.equalTo(backButton)
                $0.left.equalTo(backButton.snp.right).offset(StaticSize.size(2))
                $0.right.equalToSuperview().offset(-StaticSize.size(15))
            })
            :
            titleLabel.snp.makeConstraints({
                $0.top.equalTo(backButton.snp.bottom).offset(StaticSize.size(20))
                $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            })
        
        contentView.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(StaticSize.size(20))
            $0.left.right.bottom.equalToSuperview()
        })
        
        bottomButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.centerX.equalToSuperview()
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
