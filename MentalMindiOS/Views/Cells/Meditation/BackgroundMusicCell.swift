//
//  BackgroundMusicCell.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11.12.2020.
//

import Foundation
import UIKit
import SnapKit

class BackgroundMusicCell: UITableViewCell {
    static let reuseIdentifier = "BackgroundMusicCell"
    
    var music: BackgroundMusic? {
        didSet {
            title.text = music?.name
        }
    }
    var isActive = false {
        didSet {
            radioImage.image = UIImage(named: isActive ? "radioOn" : "radioOff")
        }
    }
    
    lazy var radioImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "radioOff")
        return view
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(17), weight: .light)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
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
        addSubViews([radioImage, title])
        
        radioImage.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(StaticSize.size(24))
            $0.size.equalTo(StaticSize.size(24))
        })
        
        title.snp.makeConstraints({
            $0.left.equalTo(radioImage.snp.right).offset(StaticSize.size(20))
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-StaticSize.size(24))
        })
    }
}
