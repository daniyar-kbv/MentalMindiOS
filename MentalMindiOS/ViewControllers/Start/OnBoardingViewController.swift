//
//  OnBoardingViewCOntroller.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/29/20.
//

import Foundation
import UIKit

class OnBoardingViewController: BaseViewController {
    lazy var boardingView = OnBoardingView()
    var currentIndex = 0
    
    override func loadView() {
        super.loadView()
        
        view = boardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .lightContent
        
        boardingView.collectionView.delegate = self
        boardingView.collectionView.dataSource = self
        
        configActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.addGradientBackground()
    }
    
    func configActions() {
        boardingView.nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        boardingView.backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    @objc func nextTapped() {
        currentIndex += 1
        if currentIndex < 3{
            if currentIndex == 2 {
                boardingView.nextButton.setTitle("Понятно".localized, for: .normal)
            }
            boardingView.indicatorView.setCurrent(index: currentIndex)
            boardingView.collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
        } else {
            let vc = ChooseAuthViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            ModuleUserDefaults.setIsInitial(false)
        }
    }
    
    @objc func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.reuseIdentifier, for: indexPath) as! OnBoardingCell
        switch indexPath.row {
        case 0:
            cell.title.text = "Освободи свой мозг от всех ограничений".localized
            cell.subtitle.text = "С помощью простых и уникальных инструментов".localized
        case 1:
            cell.title.text = "Ценная проработка для повышения качества жизни на каждый день".localized
            cell.subtitle.text = "Три минуты вернут тебя в потоковое состояние".localized
        case 2:
            cell.title.text = "Позволь удивительным переменам войти в твою жизнь".localized
            cell.subtitle.text = "Сделай правильный выбор, начни использовать приложение уже сейчас!".localized
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenSize.SCREEN_WIDTH, height: StaticSize.size(280))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = boardingView.collectionView.frame.size.width
        let currentPage = (boardingView.collectionView.contentOffset.x / pageWidth)
        currentIndex = Int(currentPage)
        boardingView.nextButton.setTitle(currentIndex == 2 ? "Понятно".localized : "Далее".localized, for: .normal)
        boardingView.indicatorView.setCurrent(index: currentIndex)
    }
}

