//
//  IndicatorView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/29/20.
//

import Foundation
import UIKit
import SnapKit

class IndicatorView: UIStackView {
    var number: Int
    var indicators: [UIView] = []
    
    required init(number: Int) {
        self.number = number
        for i in 0..<number{
            let new: UIView = {
                let view = UIView()
                view.layer.cornerRadius = StaticSize.size(4)
                view.backgroundColor = i == 0 ? .white : UIColor.black.withAlphaComponent(0.2)
                return view
            }()
            indicators.append(new)
        }
        
        super.init(frame: CGRect())
        
        setUp()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addArrangedSubViews(indicators)
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .center
        
        for indicator in indicators {
            indicator.snp.makeConstraints({
                $0.size.equalTo(StaticSize.size(8))
            })
        }
    }
    
    func setCurrent(index: Int){
        UIView.animate(withDuration: 0.2, animations: {
            for (i, indicator) in self.indicators.enumerated(){
                indicator.backgroundColor = i == index ? .white : UIColor.black.withAlphaComponent(0.2)
            }
        })
    }
}

