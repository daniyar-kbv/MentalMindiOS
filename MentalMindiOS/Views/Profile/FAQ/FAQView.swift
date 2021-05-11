//
//  FaqView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 15.12.2020.
//

import Foundation
import UIKit
import SnapKit

class FAQView: BaseView {
    var faqs: [FAQ]? {
        didSet {
            for faq in faqs ?? [] {
                let view = FAQInnerView()
                view.faq = faq
                stack.addArrangedSubview(view)
            }
            
        }
    }
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: Global.safeAreaBottom(), right: 0)
        return view
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        return view
    }()
    
    required init() {
        super.init()
        
        backgroundColor = .white
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(titleOnTop: Bool = true) {
        fatalError("init(titleOnTop:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubview(scrollView)
        
        scrollView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        scrollView.addSubview(stack)
        
        stack.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.width.equalTo(ScreenSize.SCREEN_WIDTH - StaticSize.size(30))
        })
    }
}
