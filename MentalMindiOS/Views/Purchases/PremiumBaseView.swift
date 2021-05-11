//
//  Purchases.swift
//  MentalMindiOS
//
//  Created by Dan on 12/23/20.
//

import Foundation
import UIKit
import SnapKit
import SafariServices

class PremiumBaseView: UIView {
    var type: ViewType
    
    lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "purchseBack")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var leftButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        switch type {
        case .preview:
            view.setBackgroundImage(UIImage(named: "closeDimmed"), for: .normal)
        case .purchase:
            view.setBackgroundImage(UIImage(named: "backDimmed"), for: .normal)
        }
        return view
    }()
    
    lazy var policyButton: UIButton = {
        let view = UIButton()
        let attributes: [NSAttributedString.Key : Any]
        switch type {
        case .preview:
            attributes = [
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue,
                NSAttributedString.Key.font: UIFont.montserrat(ofSize: StaticSize.size(12), weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)
            ]
        case .purchase:
            attributes = [
                NSAttributedString.Key.font: UIFont.montserrat(ofSize: StaticSize.size(14), weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.5)
            ]
        }
        let attributedString = NSAttributedString(
            string: "Политика конфиденциальности".localized,
            attributes: attributes
        )
        view.setAttributedTitle(attributedString, for: .normal)
        view.addTarget(self, action: #selector(openPolicy), for: .touchUpInside)
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    required init(type: ViewType) {
        self.type = type
        
        super.init(frame: .zero)
        
        layer.masksToBounds = true
        
        addSubViews([backgroundImage, leftButton, contentView])
        
        backgroundImage.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        leftButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(Global.safeAreaTop())
            $0.left.equalToSuperview()
            $0.size.equalTo(StaticSize.size(50))
        })
        
        contentView.snp.makeConstraints({
            $0.top.equalTo(leftButton.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        })
        
//        policyButton.snp.makeConstraints({
//            $0.left.equalToSuperview().offset(StaticSize.size(15))
//            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
//        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func leftButtonTapped() {
        AppShared.sharedInstance.navigationController.popViewController(animated: true)
    }
    
    @objc func openPolicy() {
        guard let url = URL(string: "https://server.mentalmind.kz/media/privacy_policy_and_oferta.pdf") else { return }
        let vc = SFSafariViewController(url: url, configuration: SFSafariViewController.Configuration())
        UIApplication.topViewController()?.present(vc, animated: true)
    }
    
    enum ViewType {
        case preview
        case purchase
    }
}


class PremiumDescriptionView: UIStackView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        axis = .vertical
        distribution = .equalSpacing
        alignment = .fill
        spacing = StaticSize.size(10)
        
        addArrangedSubViews(PremiumDescriptionSubView.ViewType.allCases.map({
            PremiumDescriptionSubView(type: $0)
        }))
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PremiumDescriptionSubView: UIView {
    var type: ViewType
    
//    lazy var leftImage: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage(named: "tick")
//        return view
//    }()
    
    lazy var leftImage: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = StaticSize.size(4)
        return view
    }()
    
    lazy var textView: UILabel = {
        let view = UILabel()
        view.font = .montserrat(ofSize: StaticSize.size(14), weight: .medium)
        view.textColor = .white
        view.text = type.text
        view.numberOfLines = 0
        return view
    }()
    
    required init(type: ViewType) {
        self.type = type
        
        super.init(frame: .zero)
        
        addSubViews([leftImage, textView])
        
        leftImage.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(3))
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.size.equalTo(StaticSize.size(8))
        })
        
        textView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.equalTo(leftImage.snp.right).offset(StaticSize.size(13))
            $0.right.equalToSuperview().offset(-StaticSize.size(15))
            $0.bottom.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum ViewType: CaseIterable {
        case first
        case second
        
        var text: String {
            switch self {
            case .first:
                return "Неограниченный доступ к более, чем 200+ инструментам для вашего развития и роста".localized
            case .second:
                return "Система ежедневного встраивания сверхчеловеческой продуктивности".localized
            }
        }
    }
}
