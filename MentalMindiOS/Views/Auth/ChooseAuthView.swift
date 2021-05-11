//
//  ChooseAuthView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/29/20.
//

import Foundation
import UIKit
import SnapKit

class ChooseAuthView: AuthBaseView {
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = StaticSize.buttonHeight + StaticSize.size(16)
        view.isScrollEnabled = false
        view.allowsSelection = false
        view.register(ChooseAuthCell.self, forCellReuseIdentifier: ChooseAuthCell.reuseIdentifier)
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()
    
    required init(titleOnTop: Bool = true) {
        super.init(titleOnTop: titleOnTop)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([tableView])
        
        tableView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(61))
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
}
 
