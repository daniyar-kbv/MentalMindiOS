//
//  Loader.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/30/20.
//

import Foundation
import SnapKit
import UIKit

class Loader: UIView {
    static var speed: Float = 0.5
    private var timer: Timer?
    private var progress: Float = 0 {
        didSet {
            progressBar.snp.remakeConstraints({
                $0.left.top.bottom.equalToSuperview()
                $0.width.equalToSuperview().multipliedBy(progress/(100))
            })
            
            if progress >= 100 {
                timer?.invalidate()
            }

            let currentProgress = progress
            
            UIView.animate(withDuration: 0.5, animations: {
                self.superview?.layoutIfNeeded()
            }, completion: { finished in
                if finished && currentProgress >= 100 {
                    self.removeFromSuperview()
                }
            })
        }
    }
    
    lazy var progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = .customLightGreen
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .customLoaderGray
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubview(progressBar)

        progressBar.snp.makeConstraints({
            $0.left.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(progress/100)
        })
    }
    
    static func show(_ view: UIView? = nil) -> Loader {
        let loader = Loader()
        
        if let view = view {
            loader.addToView(view: view)
        } else if let view = UIApplication.topViewController()?.view{
            loader.addToView(view: view)
        }
        
        let taskId = UIApplication.shared.beginBackgroundTask() {
            loader.removeFromSuperview()
        }
        loader.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if loader.progress < 100 {
                loader.progress += 1
            } else {
                loader.timer?.invalidate()
                loader.removeFromSuperview()
                UIApplication.shared.endBackgroundTask(taskId)
            }
        }
        
        return loader
    }
    
    private func addToView(view: UIView) {
        view.addSubview(self)
        
        self.snp.makeConstraints({
            $0.top.equalToSuperview().offset(Global.safeAreaTop())
            $0.left.right.equalToSuperview()
            $0.height.equalTo(StaticSize.size(2))
        })
    }
    
    func setProgress(_ number: Float) {
        if number > progress {
            progress = number
        }
    }
}
