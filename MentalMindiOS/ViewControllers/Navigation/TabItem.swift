//
//  TabItem.swift
//  GOALSTER
//
//  Created by Daniyar on 8/11/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

enum TabItem: String, CaseIterable {
    case main
    case instruments
    case create
    case profile
    
    var viewController: UIViewController {
        switch self {
        case .main:
            return MainViewController()
        case .instruments:
            return InstrumentsViewController()
        case .create:
            return CreateViewController()
        case .profile:
            return ProfileMainViewController()
        }
    }
    
    var icon_active: UIImage {
        return UIImage(named: "\(self.rawValue)Active")!
    }
    
    var icon_inactive: UIImage {
        return UIImage(named: "\(self.rawValue)Inactive")!
    }
    
    var name: String {
        switch self {
        case .main:
            return "Главная".localized
        case .instruments:
            return "Инструменты".localized
        case .create:
            return "Созидай".localized
        case .profile:
            return "Профиль".localized
        }
    }
}
