//
//  FeelingsViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation
import UIKit
import RxSwift

class FeelingsViewController: InnerViewController<FeelingsViewModel> {
    lazy var feelingsView = FeelingsView()
    lazy var disposeBag = DisposeBag()
    
    var feelings: [Feeling]? {
        didSet {
            feelingsView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = feelingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .lightContent
        
        feelingsView.setTitle("Что беспокоит?".localized)
        viewModel = FeelingsViewModel()
        
        feelingsView.collectionView.delegate = self
        feelingsView.collectionView.dataSource = self
        
        bind()
    }
    
    func bind() {
        viewModel?.feelings.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.feelings = object.sorted(by: {
                    $0.id ?? 0 < $1.id ?? 0
                })
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func buttonTapped(_ button: UIButton) {
        guard let id = feelings?[button.tag].id else { return }
        AppShared.sharedInstance.feelingId = id
        navigationController?.popViewController(animated: true)
    }
}

extension FeelingsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feelings?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeelingsCell.reuseIdentifier, for: indexPath) as! FeelingsCell
        cell.feeling = feelings?[indexPath.row]
        cell.index = indexPath.row
        cell.container.tag = indexPath.row
        cell.container.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (ScreenSize.SCREEN_WIDTH - StaticSize.size(20)) / 2, height: StaticSize.size(58))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
