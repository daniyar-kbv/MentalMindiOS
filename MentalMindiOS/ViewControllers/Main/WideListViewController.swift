//
//  WideListViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/2/20.
//

import Foundation
import UIKit
import RxSwift


class WideListViewController<T>: InnerViewController<WideListViewModel>, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    lazy var listView = WideListView<Any>()
    lazy var disposeBag = DisposeBag()
    var challengeId: Int?
    
    var currentPage = 1
    var items: [T]? {
        didSet {
            listView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listView.setTitle("Ежедневный челлендж".localized)
        
        listView.collectionView.delegate = self
        listView.collectionView.dataSource = self
        
        viewModel = WideListViewModel()
        viewModel?.superVc = self as? WideListViewController<Any>
        
        bind()
    }
    
    func bind() {
        viewModel?.collections.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.items = object as? [T]
            }
        }).disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell<T>.getReuseIdenifier(), for: indexPath) as! CollectionCell<T>
        cell.type = .wide
        cell.item = items?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenSize.SCREEN_WIDTH - StaticSize.size(30), height: StaticSize.size(232))
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionCell<Any>
        cell.showTap(subview: cell.imageView)
        switch cell.item.self{
        case is Challenge:
            let vc = WideListViewController<Any>()
            vc.challengeId = (cell.item as? Challenge)?.id
            AppShared.sharedInstance.navigationController.pushViewController(vc, animated: true)
        case is Course:
            if let url = URL(string: (cell.item as? Course)?.url ?? "") {
                UIApplication.shared.open(url)
            }
        case is Collection:
            let vc = MeditationListViewController()
            vc.collectionId = (cell.item as? Collection)?.id
            AppShared.sharedInstance.navigationController.pushViewController(vc, animated: true)
        case is Meditation:
            let vc = MeditationListViewController()
            vc.collectionId = (cell.item as? Meditation)?.collectionId
            AppShared.sharedInstance.navigationController.pushViewController(vc, animated: true)
        case is Affirmation:
            let vc = AffirmationDetailViewController()
            vc.affirmation = cell.item as? Affirmation
            AppShared.sharedInstance.navigationController.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
