//
//  LevelsView.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation
import UIKit
import SnapKit

class LevelsView: BaseView {
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(LevelCell.self, forCellReuseIdentifier: LevelCell.reuseIdentifier)
        view.rowHeight = StaticSize.levelViewHeight + StaticSize.size(45)
        view.showsVerticalScrollIndicator = false
        view.separatorStyle = .none
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: StaticSize.size(30), left: 0, bottom: 0, right: 0)
        return view
    }()
    
    required init() {
        super.init(titleOnTop: true)
        
        backgroundColor = .white
        barStyle = .darkContent
        
        setUp()
    }
    
    func setUp() {
        contentView.addSubview(tableView)
        
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
