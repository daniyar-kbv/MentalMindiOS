//
//  meditationDetailView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 08.12.2020.
//

import Foundation
import UIKit
import SnapKit

class MeditationDetailView: MeditationBaseView {
    var meditation: MeditationDetail? {
        didSet {
            titleLabel.text = meditation?.name
            descriptionLabel.text = meditation?.description_
            currentTimeLabel.text = "00:00"
            totalTimeLabel.text = meditation?.duration?.toTime() ?? ""
            slider.minimumValue = 0
            slider.maximumValue = Float(meditation?.duration ?? 0)
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(18), weight: .bold)
        label.textColor = .customTextBlack
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var descriptionLabel: CustomLabelWithoutPadding = {
        let label = CustomLabelWithoutPadding()
        label.font = .montserrat(ofSize: StaticSize.size(14), weight: .regular)
        label.textColor = .customTextBlack
        return label
    }()
    
    lazy var backgoundMusicButton: MeditationInnerButton = {
        let view = MeditationInnerButton(type: .backgroundMusic)
        view.value.text = BackgroundMusic.wayToHarmony.name
        return view
    }()
    
    lazy var dictorVoiceButton: MeditationInnerButton = {
        let view = MeditationInnerButton(type: .dictorVoice)
        view.value.text = VoiceTypes.female.title
        return view
    }()
    
    lazy var buttonsStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [backgoundMusicButton, dictorVoiceButton])
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .center
        return view
    }()
    
    lazy var backControllButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "backSmall"), for: .normal)
        return view
    }()
    
    lazy var playControllButton: TwoStatesButton = {
        let view = TwoStatesButton(activeImage: UIImage(named: "pauseSmall"), inactiveImage: UIImage(named: "playSmall"), isActive: false)
        view.setBackgroundImage(UIImage(named: "playSmall"), for: .normal)
        return view
    }()
    
    lazy var nextControllButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "nextSmall"), for: .normal)
        return view
    }()
    
    lazy var controllStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [backControllButton, playControllButton, nextControllButton])
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .center
        view.spacing = StaticSize.size(43)
        return view
    }()
    
    lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(12), weight: .regular)
        label.textColor = .customTextBlack
        return label
    }()
    
    lazy var totalTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(12), weight: .regular)
        label.textColor = .customTextBlack
        return label
    }()
    
    lazy var slider: CustomSlider = {
        let view = CustomSlider()
        return view
    }()
    
    lazy var sliderContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    required init() {
        super.init(type: .detail)
        
        backgroundColor = .gray
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(type: MeditationViewType) {
        fatalError("init(type:) has not been implemented")
    }
    
    func setUp() {
        titleContainer.addSubViews([titleLabel, descriptionLabel])
        
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(20))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        descriptionLabel.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(StaticSize.size(2))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.bottom.equalToSuperview()
        })
        
        innerContainer.addSubViews([buttonsStack, controllStack, sliderContainer])
        
        buttonsStack.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(5))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        for button in buttonsStack.arrangedSubviews{
            button.snp.makeConstraints({
                $0.width.equalTo(StaticSize.size(162))
                $0.height.equalTo(StaticSize.size(41))
            })
        }
        
        controllStack.snp.makeConstraints({
            $0.top.equalTo(buttonsStack.snp.bottom).offset(StaticSize.size(25))
            $0.centerX.equalToSuperview()
        })
        
        for controll in controllStack.arrangedSubviews {
            controll.snp.makeConstraints({
                $0.size.equalTo(StaticSize.size(30))
            })
        }
        
        sliderContainer.snp.makeConstraints({
            $0.top.equalTo(controllStack.snp.bottom).offset(StaticSize.size(17))
            $0.left.right.bottom.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-(StaticSize.size(30) + Global.safeAreaBottom()))
        })
        
        sliderContainer.addSubViews([currentTimeLabel, totalTimeLabel, slider])
        
        currentTimeLabel.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.bottom.equalToSuperview()
        })
        
        totalTimeLabel.snp.makeConstraints({
            $0.centerY.equalTo(currentTimeLabel)
            $0.right.equalToSuperview().offset(-StaticSize.size(15))
        })
        
        slider.snp.makeConstraints({
            $0.centerY.equalTo(totalTimeLabel)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(StaticSize.size(250))
        })
    }
}
