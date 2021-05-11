//
//  ChangeLanugageView.swift
//  MentalMindiOS
//
//  Created by Dan on 12/21/20.
//

import Foundation
import UIKit
import SnapKit

class ChangeLanugageView: BaseView {
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseidentifier)
        view.isScrollEnabled = false
        view.backgroundColor = .clear
        view.rowHeight = StaticSize.size(48)
        view.separatorStyle = .none
        return view
    }()
    
    lazy var bottomButton: CustomButton = {
        let view = CustomButton()
        view.backgroundColor = .customBlue
        view.setTitle("Отправить".localized, for: .normal)
        view.titleLabel?.font = .montserrat(ofSize: StaticSize.size(17), weight: .medium)
        view.setTitleColor(.white, for: .normal)
        view.isActive = false
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
        contentView.addSubViews([tableView, bottomButton])
        
        tableView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(20))
            $0.left.right.bottom.equalToSuperview()
        })
        
        bottomButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.height.equalTo(StaticSize.buttonHeight)
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
    }
}
