//
//  TableView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/3/20.
//

import Foundation
import UIKit

class TableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        showsVerticalScrollIndicator = false
        separatorStyle = .none
        backgroundColor = .clear
        allowsSelection = false
        delaysContentTouches = false
        contentInset = UIEdgeInsets(top: 0, left: 0, bottom: StaticSize.tabBarHeight, right: 0)
        register(TableCell<Any>.self, forCellReuseIdentifier: TableCell<Any>().identifier)
        register(CurrentListenersCell.self, forCellReuseIdentifier: CurrentListenersCell.reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
