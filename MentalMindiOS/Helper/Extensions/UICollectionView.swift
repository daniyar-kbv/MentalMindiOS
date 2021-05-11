//
//  UICollectionView.swift
//  Samokat
//
//  Created by Daniyar on 7/15/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    func reloadData(onCompletion: ((Bool) -> Void)?){
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: onCompletion)
    }
    
    func reloadSections(_ indexSet: IndexSet, onCompletion: ((Bool) -> Void)?){
        UIView.animate(withDuration: 0, animations: {
            self.reloadSections(indexSet)
        }, completion: onCompletion)
    }
}
