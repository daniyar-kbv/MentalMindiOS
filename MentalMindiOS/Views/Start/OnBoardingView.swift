//
//  OnBoardingView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/29/20.
//

import Foundation
import UIKit

class OnBoardingView: UIView {
    lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "startBackground")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var backButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "arrowLeftBack"), for: .normal)
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
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.isPagingEnabled = true
        view.register(OnBoardingCell.self, forCellWithReuseIdentifier: OnBoardingCell.reuseIdentifier)
        return view
    }()
    
    lazy var indicatorView: IndicatorView = {
        let view = IndicatorView(number: 3)
        return view
    }()
    
    lazy var nextButton: CustomButton = {
        let view = CustomButton()
        view.setTitle("Далее", for: .normal)
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
        addSubViews([backgroundView, backButton, logoView, title, collectionView, indicatorView, nextButton])
        
        backgroundView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        backButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(Global.safeAreaTop())
            $0.left.equalToSuperview()
            $0.size.equalTo(StaticSize.size(48))
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
        
        collectionView.snp.makeConstraints({
            $0.top.equalTo(title.snp.bottom).offset(StaticSize.size(37))
            $0.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.size(280))
        })
        
        indicatorView.snp.makeConstraints({
            $0.top.equalTo(collectionView.snp.bottom).offset(StaticSize.size(8))
            $0.centerX.equalToSuperview()
            $0.height.equalTo(StaticSize.size(8))
            $0.width.equalTo(StaticSize.size(44))
        })
        
        nextButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
}
