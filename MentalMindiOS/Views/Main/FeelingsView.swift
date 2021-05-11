//
//  FeelingsView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation
import UIKit
import SnapKit

class FeelingsView: BaseView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.delaysContentTouches = false
        view.register(FeelingsCell.self, forCellWithReuseIdentifier: FeelingsCell.reuseIdentifier)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addGradientBackground(colors: [.customBlue, .customGreen])
    }
    
    required init() {
        super.init()
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(titleOnTop: Bool = true) {
        fatalError("init(titleOnTop:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([collectionView])
        
        collectionView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(25))
            $0.left.right.equalToSuperview().inset(StaticSize.size(10))
            $0.bottom.equalToSuperview()
        })
    }
}
