//
//  MeditationListView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 07.12.2020.
//

import Foundation
import SnapKit
import UIKit

class MeditationListView: MeditationBaseView {
    var isActive: Bool = false {
        didSet {
            playButton.setBackgroundImage(UIImage(named: isActive ? "pauseBig" : "playBig"), for: .normal)
        }
    }
    var isMore = false {
        didSet {
            
        }
    }
    
    lazy var playButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "playBig"), for: .normal)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(18), weight: .bold)
        label.textColor = .customTextBlack
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(14), weight: .regular)
        label.numberOfLines = 0
        label.textColor = .customTextBlack
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var moreButton: MoreButton = {
        let view = MoreButton()
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.register(MeditationCell.self, forCellReuseIdentifier: MeditationCell.reuseIdentifier)
        view.contentInset = UIEdgeInsets(top: StaticSize.size(2), left: 0, bottom: Global.safeAreaBottom(), right: 0)
        view.rowHeight = StaticSize.size(50)
        return view
    }()
    
    required init() {
        super.init(type: .list)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(type: MeditationViewType) {
        fatalError("init(type:) has not been implemented")
    }
    
    func setUp() {
        insertSubview(playButton, belowSubview: mainContainer)
        
        playButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(268) + Global.safeAreaTop())
            $0.centerX.equalToSuperview()
            $0.size.equalTo(StaticSize.size(83))
        })
        
        titleContainer.addSubViews([titleLabel, descriptionLabel, moreButton])
        
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(20))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        descriptionLabel.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(StaticSize.size(8))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.size(40))
        })
        
        moreButton.snp.makeConstraints({
            $0.top.equalTo(descriptionLabel.snp.bottom)
            $0.right.equalToSuperview().offset(-StaticSize.size(15))
            $0.bottom.equalToSuperview()
            $0.height.equalTo(StaticSize.size(32))
            $0.width.equalTo(StaticSize.size(103))
        })
        
        innerContainer.addSubViews([tableView])
        
        tableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}
