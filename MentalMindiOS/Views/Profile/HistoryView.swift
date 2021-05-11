//
//  HistoryView.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation
import UIKit
import SnapKit

class HistoryView: BaseView {
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.reuseIdentifier)
        view.rowHeight = StaticSize.size(28)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .none
        view.separatorStyle = .none
        view.contentInset = UIEdgeInsets(top: StaticSize.size(9), left: 0, bottom: 0, right: 0)
        return view
    }()
    
    required init() {
        super.init(titleOnTop: true)
        
        barStyle = .darkContent
        backgroundColor = .white
        
        setUp()
    }
    
    func setUp() {
        contentView.addSubViews([tableView])
        
        tableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(titleOnTop: Bool = true) {
        fatalError("init(titleOnTop:) has not been implemented")
    }
}
