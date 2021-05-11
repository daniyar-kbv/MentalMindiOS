//
//  LanguageView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/29/20.
//

import Foundation
import UIKit
import SnapKit

class LanguageView: UIView {
    lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "startBackground")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var logoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "launchLogo")
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.font = .jura(ofSize: StaticSize.size(24), weight: .light)
        view.textColor = .white
        view.text = "Mentalmind"
        return view
    }()
    
    lazy var kazakhButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Казак тiлi", for: .normal)
        return view
    }()
    
    lazy var russianButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Русский язык", for: .normal)
        return view
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [kazakhButton, russianButton])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = StaticSize.size(16)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubViews([backgroundView, logoView, title, stack])
        
        backgroundView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        logoView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(32) + Global.safeAreaTop())
            $0.centerX.equalToSuperview()
            $0.size.equalTo(StaticSize.size(92))
        })
        
        title.snp.makeConstraints({
            $0.top.equalTo(logoView.snp.bottom).offset(StaticSize.size(13))
            $0.centerX.equalToSuperview()
        })
        
        stack.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        for view in stack.arrangedSubviews {
            view.snp.makeConstraints({
                $0.height.equalTo(StaticSize.buttonHeight)
            })
        }
    }
}
