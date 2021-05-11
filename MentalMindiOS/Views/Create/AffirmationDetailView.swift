//
//  AffiramtionDetailView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 14.12.2020.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class AffirmationDetailView: UIView {
    var affirmation: Affirmation? {
        didSet {
            backgroundImage.kf.setImage(with: URL(string: affirmation?.fileImage ?? ""))
            titleLabel.text = affirmation?.name
            descriptionLabel.text = affirmation?.description
        }
    }
    
    lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var darkView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    lazy var backButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "backSquare"), for: .normal)
        view.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return view
    }()
    
    lazy var shareButton = ShareButton()
    
    lazy var titleLabel: CustomLabelWithoutPadding = {
        let label = CustomLabelWithoutPadding()
        label.font = .montserrat(ofSize: StaticSize.size(28), weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var descriptionLabel: CustomLabelWithoutPadding = {
        let label = CustomLabelWithoutPadding()
        label.font = .montserrat(ofSize: StaticSize.size(22), weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubViews([backgroundImage, darkView, backButton, shareButton, line, titleLabel, descriptionLabel])
        
        backgroundImage.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        darkView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        backButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(6) + Global.safeAreaTop())
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.size.equalTo(StaticSize.size(40))
        })
        
        shareButton.snp.makeConstraints({
            $0.right.equalToSuperview().offset(-StaticSize.size(15))
            $0.top.equalToSuperview().offset(StaticSize.size(6) + Global.safeAreaTop())
            $0.size.equalTo(StaticSize.size(40))
        })
        
        line.snp.makeConstraints({
            $0.top.equalToSuperview().offset(Global.safeAreaTop() + StaticSize.size(302))
            $0.left.right.equalToSuperview().inset(StaticSize.size(82))
            $0.height.equalTo(StaticSize.size(1))
        })
        
        titleLabel.snp.makeConstraints({
            $0.bottom.equalTo(line.snp.top).offset(-StaticSize.size(10))
            $0.left.right.equalToSuperview().inset(StaticSize.size(21))
        })
        
        descriptionLabel.snp.makeConstraints({
            $0.top.equalTo(line.snp.bottom).offset(StaticSize.size(16))
            $0.left.right.equalToSuperview().inset(StaticSize.size(21))
        })
    }
    
    @objc func backTapped() {
        AppShared.sharedInstance.navigationController.popViewController(animated: true)
    }
}
