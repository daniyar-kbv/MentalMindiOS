//
//  LevelView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 14.12.2020.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher
import JTAppleCalendar

class LevelView: UIView {
    var type: LevelViewType?
    var level: Level? {
        didSet {
            imageView.kf.setImage(with: URL(string: level?.fileImage ?? ""))
            titleLabel.text = level?.name
            if let days = level?.daysWithUs, let minutes = level?.listenedMinutes {
                switch type {
                case .profile:
                    leftButton.setTitle(days.toTime(timeType: .days), for: .normal)
                    rightButton.setTitle(minutes.toTime(timeType: .minutes), for: .normal)
                case .list:
                    leftButton.setTitle("\("От".localized) \(days.toTime(resultCase: .genetive, timeType: .days))", for: .normal)
                    rightButton.setTitle("\("От".localized) \(minutes.toTime(resultCase: .genetive, timeType: .minutes))", for: .normal)
                default:
                    break
                }
            }
        }
    }
    
    lazy var shadowContainer: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: StaticSize.size(1))
        view.layer.shadowRadius = StaticSize.size(3)
        view.layer.shadowOpacity = 0.15
        return view
    }()
    
    lazy var mainContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = StaticSize.size(10)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var leftButton: GradientButton = {
        let view = GradientButton()
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .montserrat(ofSize: StaticSize.size(16), weight: .semiBold)
        view.layer.cornerRadius = StaticSize.size(25)
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(12), weight: .regular)
        label.textColor = .customTextBlack
        label.text = "на пути к себе".localized
        return label
    }()
    
    lazy var rightButton: GradientButton = {
        let view = GradientButton()
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .montserrat(ofSize: StaticSize.size(16), weight: .semiBold)
        view.layer.cornerRadius = StaticSize.size(25)
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(12), weight: .regular)
        label.textColor = .customTextBlack
        label.text = "самопознания".localized
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(24), weight: .extraBold)
        label.textColor = .customTextBlack
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var questionButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "questionMark"), for: .normal)
        view.addTarget(self, action: #selector(questionTapped), for: .touchUpInside)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func questionTapped() {
        AppShared.sharedInstance.navigationController.pushViewController(LevelsViewController(), animated: true)
    }
    
    func setUp() {
        addSubViews([shadowContainer, leftButton, rightButton, leftLabel, rightLabel])
        
        shadowContainer.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(10))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.bottom.equalToSuperview().offset(StaticSize.size(-71))
        })
        
        leftButton.snp.makeConstraints({
            $0.top.equalTo(shadowContainer.snp.bottom).offset(-StaticSize.size(25))
            $0.left.equalTo(shadowContainer).offset(StaticSize.size(15))
            $0.right.equalTo(shadowContainer.snp.centerX).offset(-StaticSize.size(10))
            $0.height.equalTo(StaticSize.size(50))
        })
        
        leftLabel.snp.makeConstraints({
            $0.top.equalTo(leftButton.snp.bottom)
            $0.centerX.equalTo(leftButton)
        })
        
        rightButton.snp.makeConstraints({
            $0.centerY.equalTo(shadowContainer.snp.bottom)
            $0.right.equalTo(shadowContainer).offset(-StaticSize.size(15))
            $0.left.equalTo(shadowContainer.snp.centerX).offset(StaticSize.size(10))
            $0.height.equalTo(StaticSize.size(50))
        })
        
        rightLabel.snp.makeConstraints({
            $0.top.equalTo(rightButton.snp.bottom)
            $0.centerX.equalTo(rightButton)
        })
        
        shadowContainer.addSubViews([mainContainer])
        
        mainContainer.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        mainContainer.addSubViews([imageView, titleLabel, questionButton])
        
        imageView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(15))
            $0.size.equalTo(StaticSize.size(100))
            $0.centerX.equalToSuperview()
        })
        
        titleLabel.snp.makeConstraints({
            $0.top.equalTo(imageView.snp.bottom).offset(StaticSize.size(2))
            $0.centerX.equalToSuperview()
        })
        
        questionButton.snp.makeConstraints({
            $0.right.top.equalToSuperview()
            $0.size.equalTo(StaticSize.size(44))
        })
    }
}
