//
//  PolicyButton.swift
//  MentalMindiOS
//
//  Created by Dan on 4/21/21.
//

import Foundation
import UIKit
import SafariServices

class PolicyButton: UIButton {
    var isActive = false {
        didSet {
            checkImage.image = UIImage(named: isActive ? "check_full" : "check_empty")
        }
    }
    var onTap: ((_ button: PolicyButton)->())?
    
    lazy var checkImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "check_empty")
        return view
    }()
    
    lazy var tappableLabel: UILabel = {
        let view = UILabel()
        let text = NSMutableAttributedString(
            string: "Договор".localized,
            attributes: [
                NSAttributedString.Key.font: UIFont.montserrat(ofSize: StaticSize.size(12), weight: .regular),
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
                NSAttributedString.Key.underlineColor: UIColor.white
            ]
        )
        view.attributedText = text
        let gesture = UITapGestureRecognizer(target: self, action: #selector(policyTapped))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return view
    }()
    
    lazy var justLabel: UILabel = {
        let view = UILabel()
        view.text = "мною прочитан, мне понятен, я согласен".localized
        view.textColor = .white
        view.font = .montserrat(ofSize: StaticSize.size(12), weight: .regular)
        view.isUserInteractionEnabled = false
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    @objc func policyTapped() {
        guard let url = URL(string: "https://server.mentalmind.kz/media/privacy_policy_and_oferta.pdf") else { return }
        let vc = SFSafariViewController(url: url, configuration: SFSafariViewController.Configuration())
        UIApplication.topViewController()?.present(vc, animated: true)
    }
    
    @objc func onPolicyTap() {
        isActive.toggle()
        onTap?(self)
    }
    
    func setUp() {
        addSubViews([checkImage, tappableLabel, justLabel])
        
        checkImage.snp.makeConstraints({
            $0.top.bottom.left.equalToSuperview()
            $0.size.equalTo(StaticSize.size(18))
        })
        
        tappableLabel.snp.makeConstraints({
            $0.left.equalTo(checkImage.snp.right).offset(StaticSize.size(8))
            $0.top.bottom.equalToSuperview()
        })
        
        justLabel.snp.makeConstraints({
            $0.left.equalTo(tappableLabel.snp.right).offset(StaticSize.size(3))
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview().priority(.low)
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(onPolicyTap), for: .touchUpInside)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
