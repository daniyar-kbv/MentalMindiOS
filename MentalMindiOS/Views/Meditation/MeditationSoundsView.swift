//
//  MeditationSoundsView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11.12.2020.
//

import Foundation
import UIKit
import SnapKit

class MeditationSoundsView: MeditationInnerBaseView {
    lazy var dictorsVoiceLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(24), weight: .regular)
        label.textColor = .white
        label.text = "Голос диктора".localized
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var womenVoiceButton = VoiceButton(type: .female)
    
    lazy var menVoiceButton = VoiceButton(type: .male)
    
    lazy var voiceStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [womenVoiceButton, menVoiceButton])
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = StaticSize.size(15)
        return view
    }()
    
    lazy var backgroundMusicLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(24), weight: .regular)
        label.textColor = .white
        label.text = "Фоновая музыка".localized
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var slider = BackgroundVolumeSlider()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.rowHeight = StaticSize.size(56)
        view.separatorStyle = .none
        view.register(BackgroundMusicCell.self, forCellReuseIdentifier: BackgroundMusicCell.reuseIdentifier)
        view.showsVerticalScrollIndicator = false
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
        addSubViews([dictorsVoiceLabel, voiceStack, backgroundMusicLabel, slider, tableView])
        
        dictorsVoiceLabel.snp.makeConstraints({
            $0.top.equalTo(backButton.snp.bottom).offset(StaticSize.size(35))
            $0.left.equalToSuperview().offset(StaticSize.size(15))
        })
        
        voiceStack.snp.makeConstraints({
            $0.top.equalTo(dictorsVoiceLabel.snp.bottom).offset(StaticSize.size(21))
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.size(34))
        })
        
        backgroundMusicLabel.snp.makeConstraints({
            $0.top.equalTo(voiceStack.snp.bottom).offset(StaticSize.size(35))
            $0.left.equalToSuperview().offset(StaticSize.size(15))
        })
        
        slider.snp.makeConstraints({
            $0.top.equalTo(backgroundMusicLabel.snp.bottom).offset(StaticSize.size(29))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        tableView.snp.makeConstraints({
            $0.top.equalTo(slider.snp.bottom).offset(StaticSize.size(21))
            $0.left.right.bottom.equalToSuperview()
        })
    }
}
