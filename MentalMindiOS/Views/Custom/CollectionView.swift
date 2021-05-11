//
//  CollectionView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/3/20.
//

import Foundation
import UIKit

class CollectionView<T>: UICollectionView {
    required init(withDirection: UICollectionView.ScrollDirection) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
        delaysContentTouches = false
        contentInset = UIEdgeInsets(top: 0, left: StaticSize.size(16), bottom: 0, right: StaticSize.size(8))
        register(CollectionCell<T>.self, forCellWithReuseIdentifier: CollectionCell<T>.getReuseIdenifier())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
