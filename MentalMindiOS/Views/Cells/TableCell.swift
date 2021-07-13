//
//  TableCell.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation
import UIKit
import SnapKit

class TableCell<T>: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    lazy var identifier = "TableCell"
    
    var items: [T] = [] {
        didSet {
            loadCells()
        }
    }
    
    var cells: [CollectionCell<T>] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var type: CollectionType? {
        didSet {
            setUp()
        }
    }
    
    var type_: Type?
    
    lazy var style: CellContentStyle = .darkContent {
        didSet {
            switch style {
            case .darkContent:
                titleLabel.textColor = .customTextBlack
            case .lightContent:
                titleLabel.textColor = .white
            }
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(
            ofSize: StaticSize.size(24),
            weight: type == .challenge ?
                .bold :
                .regular
        )
        label.textColor = .customTextBlack
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var collectionView: CollectionView<Any> = {
        let view = CollectionView<Any>(withDirection: .horizontal)
        return view
    }()
    
    lazy var topLine: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var bottomLine: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadCells() {
        self.cells = Array(0..<items.count).map({
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell<T>.getReuseIdenifier(), for: IndexPath(item: $0, section: 0)) as! CollectionCell<T>
            cell.style = style
            cell.type = type
            cell.item = items[$0]
            return cell
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if topLine.superview != nil && bottomLine.superview != nil {
            topLine.addGradientBackground(colors: [.customBlue, .customGreen], direction: .leftToRight)
            bottomLine.addGradientBackground(colors: [.customBlue, .customGreen], direction: .leftToRight)
        }
    }
    
    func setUp() {
        contentView.addSubViews([titleLabel, collectionView])
        
        titleLabel.snp.remakeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(18))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        collectionView.snp.remakeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(
                type == .challenge ?
                StaticSize.size(39) :
                StaticSize.size(16)
            )
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
        
        if type == .challenge {
            contentView.addSubViews([topLine, bottomLine])
            
            topLine.snp.remakeConstraints({
                $0.top.equalTo(titleLabel.snp.bottom).offset(StaticSize.size(12))
                $0.left.equalToSuperview().offset(StaticSize.size(15))
                $0.right.equalToSuperview()
                $0.height.equalTo(StaticSize.size(2))
            })
            
            bottomLine.snp.remakeConstraints({
                $0.bottom.equalToSuperview().offset(-StaticSize.size(18))
                $0.height.equalTo(StaticSize.size(2))
                $0.left.equalToSuperview().offset(StaticSize.size(15))
                $0.right.equalToSuperview()
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
//        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell<T>.getReuseIdenifier(), for: indexPath) as! CollectionCell<T>
//        cell.style = style
//        cell.type = type
//        cell.item = items[indexPath.row]
//        return cell
        return cells[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        var width: CGFloat = 0
        switch type {
        case .challenge, .medium:
            width = StaticSize.size(237)
        case .wide, .currentListeners:
            width = collectionView.frame.width
        case .tall, .affirmations:
            width = StaticSize.size(167)
        default:
            break
        }
        return CGSize(width: width, height: height)
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
    
    override func prepareForReuse() {
        items = []
    }
}
