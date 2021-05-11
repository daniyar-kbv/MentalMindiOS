//
//  UpdateProfileView.swift
//  MentalMindiOS
//
//  Created by Dan on 12/21/20.
//

import Foundation
import UIKit
import SnapKit

class UpdateProfileView: BaseView {
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .clear
        view.register(ProfileInputCell.self, forCellReuseIdentifier: ProfileInputCell.reuseIdentifier)
        view.separatorStyle = .none
        view.isScrollEnabled = false
        view.rowHeight = StaticSize.size(79)
        return view
    }()
    
    lazy var passwordButton: CustomButton = {
        let view = CustomButton()
        view.backgroundColor = .customLightGreen
        view.contentHorizontalAlignment = .left
        view.contentEdgeInsets = UIEdgeInsets(top: 0, left: StaticSize.size(10), bottom: 0, right: 0)
        view.setTitle("Сменить пароль".localized, for: .normal)
        view.setTitleColor(.white, for: .normal)
        return view
    }()
    
    lazy var arrowButtonImage: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = false
        view.image = UIImage(named: "arrowRightWhite")
        return view
    }()
    
    lazy var bottomButton: CustomButton = {
        let view = CustomButton()
        view.backgroundColor = .customBlue
        view.setTitle("Сохранить изменения".localized, for: .normal)
        view.titleLabel?.font = .montserrat(ofSize: StaticSize.size(17), weight: .medium)
        view.setTitleColor(.white, for: .normal)
        return view
    }()
    
    required init() {
        super.init(titleOnTop: true)
        
        backgroundColor = .white
        
        setUp()
    }
    
    required init(titleOnTop: Bool = true) {
        fatalError("init(titleOnTop:) has not been implemented")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([tableView, passwordButton, bottomButton])
        
        tableView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(22))
            $0.left.right.equalToSuperview()
        })
        
        passwordButton.snp.makeConstraints({
            $0.top.equalTo(tableView.snp.bottom).offset(StaticSize.size(52))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
        
        passwordButton.addSubViews([arrowButtonImage])
        
        arrowButtonImage.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.width.equalTo(StaticSize.size(9))
            $0.height.equalTo(StaticSize.size(15))
            $0.right.equalToSuperview().offset(-StaticSize.size(17))
        })
        
        bottomButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-(Global.safeAreaBottom() + StaticSize.size(15)))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
    
    func setTableHeight(count: Int) {
        tableView.snp.makeConstraints({
            $0.height.equalTo(tableView.rowHeight * CGFloat(count))
        })
    }
}
