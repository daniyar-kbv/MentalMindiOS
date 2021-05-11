//
//  WideListView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/2/20.
//

import Foundation
import UIKit
import SnapKit

class WideListView<T>: BaseView {
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.delaysContentTouches = false
        view.contentInset = UIEdgeInsets(top: StaticSize.size(34), left: 0, bottom: StaticSize.tabBarHeight, right: 0)
        view.register(CollectionCell<T>.self, forCellWithReuseIdentifier: CollectionCell<T>.getReuseIdenifier())
        return view
    }()
    
    required init() {
        super.init(titleOnTop: true)
        
        backgroundColor = .white
        barStyle = .darkContent
        
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
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
    }
}
