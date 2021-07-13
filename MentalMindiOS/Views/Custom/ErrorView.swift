//
//  ErrorView.swift
//  Samokat
//
//  Created by Daniyar on 7/18/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class ErrorView: UIView {
    static var initialStatusBarStyle: UIStatusBarStyle!
    static var isPresenting = false
    var completion: (() -> Void)?
    
    lazy var errorImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "error")
        return view
    }()
    
    lazy var errorLabel: CustomLabelWithoutPadding = {
        let label = CustomLabelWithoutPadding()
        label.font = .systemFont(ofSize: StaticSize.size(16), weight: .medium)
        label.textColor = .customTextBlack
        label.textAlignment  = .center
        return label
    }()
    
    lazy var errorButton: CustomButton = {
        let view = CustomButton()
        view.backgroundColor = .customLightGreen
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Повторить".localized, for: .normal)
        view.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        return view
    }()
    
    lazy var errorStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [errorImage, errorLabel, errorButton])
        view.distribution = .equalSpacing
        view.axis = .vertical
        view.alignment = .center
        view.spacing = StaticSize.size(30)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUp(){
        addSubViews([errorStack])
        
        errorStack.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview()
        })
        
        errorImage.snp.makeConstraints({
            $0.size.equalTo(StaticSize.size(106))
        })
        
        errorButton.snp.makeConstraints({
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.buttonHeight)
        })
    }
    
    static func addToView(view: UIView? = nil, text: String, completion: (() -> Void)? = nil){
        guard !isPresenting else { return }
        isPresenting = true
        
        var view = view
        if view == nil {
            view = UIApplication.topViewController()?.view
        }
        let errorView = ErrorView()
        errorView.errorLabel.text = text
        errorView.completion = completion
        
        view?.addSubview(errorView)
        errorView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        UIView.animate(withDuration: 0, animations: {
            view?.layoutIfNeeded()
        })
        
        initialStatusBarStyle = UIApplication.shared.statusBarStyle
        UIApplication.shared.statusBarStyle = .darkContent
    }
    
    @objc func onTap(){
        completion?()
        let vc = self.viewContainingController()
        removeFromSuperview()
        vc?.viewDidLoad()
        UIApplication.shared.statusBarStyle = ErrorView.initialStatusBarStyle
        ErrorView.isPresenting = false
    }
}
