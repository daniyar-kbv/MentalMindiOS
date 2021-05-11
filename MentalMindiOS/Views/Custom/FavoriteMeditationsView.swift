//
//  FavoriteMeditationsView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 15.12.2020.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

class FavoriteMeditationsView: UIView {
    lazy var disposeBag = DisposeBag()
    
    var superView: UIView?
    var favoriteMeditations: [Meditation]? = AppShared.sharedInstance.user?.favoriteMeditations {
        didSet {
            superview?.superview?.isHidden = favoriteMeditations?.isEmpty ?? true
            tableView.reloadData()
            tableView.snp.makeConstraints({
                $0.height.equalTo(((tableView.rowHeight * CGFloat(favoriteMeditations?.count ?? 0)) + StaticSize.size(24))).priority(.high)
            })
            superView?.layoutIfNeeded()
        }
    }
    
    lazy var shadowView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = StaticSize.size(3)
        view.layer.shadowOffset = CGSize(width: 0, height: StaticSize.size(1))
        view.layer.shadowOpacity = 0.15
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .white
        view.separatorStyle = .none
        view.register(MeditationCell.self, forCellReuseIdentifier: MeditationCell.reuseIdentifier)
        view.contentInset = UIEdgeInsets(top: StaticSize.size(2), left: 0, bottom: Global.safeAreaBottom(), right: 0)
        view.rowHeight = StaticSize.size(50)
        view.layer.cornerRadius = StaticSize.size(10)
        view.contentInset = UIEdgeInsets(top: StaticSize.size(12), left: 0, bottom: StaticSize.size(12), right: 0)
        view.isScrollEnabled = false
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        superview?.superview?.isHidden = favoriteMeditations?.isEmpty ?? true
        
        setUp()
        
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        AppShared.sharedInstance.userSubject.subscribe(onNext: { object in
            DispatchQueue.main.async {
                guard let favoriteMeditations = object.favoriteMeditations else { return }
                self.favoriteMeditations = favoriteMeditations
            }
        }).disposed(by: disposeBag)
    }
    
    func setUp() {
        addSubViews([shadowView])
        
        shadowView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(10))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.bottom.equalToSuperview().offset(-StaticSize.size(25))
        })
        
        shadowView.addSubViews([tableView])

        tableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}

extension FavoriteMeditationsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMeditations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MeditationCell.reuseIdentifier, for: indexPath) as! MeditationCell
        cell.meditation = favoriteMeditations?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MeditationDetailViewController()
        let meditation = favoriteMeditations?[indexPath.row]
        let meditationDetail = MeditationDetail(id: meditation?.meditationId, name: meditation?.meditationName, description_: meditation?.meditationDescription, isFavorite: true, duration: meditation?.duration, fileMaleVoice: meditation?.meditationFileMaleVoice, fileFemaleVoice: meditation?.meditationFileFemaleVoice)
        vc.collection = CollectionDetail(
            id: meditation?.collectionId,
            name: nil,
            description: nil,
            type: nil,
            fileImage: meditation?.fileImage,
            forFeeling: nil,
            tags: nil,
            meditations: [meditationDetail],
            challenges: nil)
        vc.currentMeditaion = 0
        vc.mainView.backgroundImage.kf.setImage(with: URL(string: meditation?.fileImage ?? ""))
        AppShared.sharedInstance.navigationController?.pushViewController(vc, animated: true)
    }
}
