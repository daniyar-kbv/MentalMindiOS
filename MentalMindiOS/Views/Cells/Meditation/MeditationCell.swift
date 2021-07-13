//
//  MeditationCell.swift
//  MentalMindiOS
//
//  Created by Daniyar on 07.12.2020.
//

import Foundation
import UIKit
import SnapKit

class MeditationCell: UITableViewCell {
    static let reuseIdentifier = "MeditationCell"
    
    var meditation: Meditation? {
        didSet {
            isActive = meditation?.meditationFileMaleVoice != nil || meditation?.meditationFileFemaleVoice != nil
            titleLabel.text = meditation?.meditationName
            timeLabel.text = "\((meditation?.getDuration(.female) ?? 0) / 60) \("мин.".localized)"
        }
    }
    
    var isActive: Bool = true {
        didSet {
            playImage.image = UIImage(named: isActive ? "playMedium" : "blockedBig")
        }
    }
    
    lazy var playImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "playMedium")
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(14), weight: .regular)
        label.textColor = .customTextBlue
        label.adjustsFontSizeToFitWidth = true
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(12), weight: .regular)
        label.textColor = .customTextBlue
        label.adjustsFontSizeToFitWidth = true
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([playImage, timeLabel, titleLabel])
        
        playImage.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.size.equalTo(StaticSize.size(42))
        })
        
        timeLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(StaticSize.size(-15)).priority(.high)
        })
        
        titleLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalTo(playImage.snp.right).offset(StaticSize.size(8))
            $0.right.equalTo(timeLabel.snp.left).offset(-StaticSize.size(10))
        })
    }
}
