//
//  MeditationBaseView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 07.12.2020.
//

import Foundation
import UIKit
import SnapKit

class MeditationBaseView: UIView {
    var type: MeditationViewType
    var isUp: Bool = false
    var initialHeight: CGFloat
    var startHeight: CGFloat
    
    lazy var backgroundImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var backButton: UIButton = {
        let view = UIButton()
        view.setBackgroundImage(UIImage(named: "backSquare"), for: .normal)
        view.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return view
    }()
    
    lazy var likeButton: TwoStatesButton = {
        let view = TwoStatesButton(activeImage: UIImage(named: "likeSquareOn"), inactiveImage: UIImage(named: "likeSquare"), isActive: false)
        return view
    }()
    
    lazy var shareButton = ShareButton()
    
    lazy var mainContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = StaticSize.size(15)
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        return view
    }()
    
    lazy var titleContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var innerContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    required init(type: MeditationViewType) {
        self.type = type
        
        switch type {
        case .detail:
            initialHeight = StaticSize.size(265 + Global.safeAreaBottom())
            startHeight = StaticSize.size(265 + Global.safeAreaBottom())
        case .list:
            initialHeight = StaticSize.size(206 + Global.safeAreaBottom())
            startHeight = StaticSize.size(206 + Global.safeAreaBottom())
        }
        
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        setUI()
    }
    
    func setUI() {
        addSubViews([backgroundImage, backButton, mainContainer])
        
        backgroundImage.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        backButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(6) + Global.safeAreaTop())
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.size.equalTo(StaticSize.size(40))
        })
        
        mainContainer.snp.makeConstraints({
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(StaticSize.size(15))
            if type == .list {
                $0.height.equalTo(initialHeight)
            }
        })
        
        mainContainer.addSubViews([titleContainer, innerContainer])
        
        titleContainer.snp.makeConstraints({
            $0.top.left.right.equalToSuperview()
        })
        
        innerContainer.snp.makeConstraints({
            $0.top.equalTo(titleContainer.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        })
        
        switch type {
        case .list:
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanTray(sender:)))
            titleContainer.addGestureRecognizer(panGesture)
        case .detail:
            addSubViews([shareButton, likeButton])
            
            shareButton.snp.makeConstraints({
                $0.right.equalToSuperview().offset(-StaticSize.size(15))
                $0.top.equalToSuperview().offset(StaticSize.size(6) + Global.safeAreaTop())
                $0.size.equalTo(StaticSize.size(40))
            })
            
            likeButton.snp.makeConstraints({
                $0.right.equalTo(shareButton.snp.left).offset(-StaticSize.size(8))
                $0.top.equalToSuperview().offset(StaticSize.size(6) + Global.safeAreaTop())
                $0.size.equalTo(StaticSize.size(40))
            })
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backTapped() {
        AppShared.sharedInstance.navigationController.popViewController(animated: true)
    }
    
    @objc func didPanTray(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        if sender.state == UIGestureRecognizer.State.began {
            initialHeight = mainContainer.frame.height
        } else if sender.state == UIGestureRecognizer.State.changed {
            let height = initialHeight - translation.y
            mainContainer.snp.updateConstraints({
                $0.height.equalTo(initialHeight - translation.y)
            })
        } else if sender.state == UIGestureRecognizer.State.ended {
            let velocity = sender.velocity(in: self)
            velocity.y > 0 ? animateDown() : animateUp()
        }
    }
    
    func animateDown(){
        isUp = false
        mainContainer.snp.updateConstraints({
            $0.height.equalTo(startHeight)
        })
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        })
    }
        
    func animateUp(){
        isUp = true
        mainContainer.snp.updateConstraints({
            $0.height.equalTo(ScreenSize.SCREEN_HEIGHT - Global.safeAreaTop() - StaticSize.size(317) + StaticSize.size(15))
        })
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
}
