//
//  CreateView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/3/20.
//

import Foundation
import UIKit
import SnapKit

class CreateView: BaseView {
    lazy var tableView: TableView = {
        let view = TableView()
        return view
    }()
    
    required init() {
        super.init(titleOnTop: false)
        
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
        contentView.addSubViews([tableView])
        
        tableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}
