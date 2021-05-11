//
//  LaunchScreenView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/29/20.
//

import Foundation
import UIKit

class LaunchScreenView: UIView {
    lazy var backgroundView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "startBackground")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var logoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "launchLogo")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubViews([backgroundView, logoView])
        
        backgroundView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        logoView.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalTo(StaticSize.size(200))
        })
    }
}
