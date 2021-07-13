//
//  MeditationListViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 07.12.2020.
//

import Foundation
import RxSwift
import UIKit
import Kingfisher

class MeditationListViewController: InnerViewController<MeditationListViewModel> {
    lazy var mainView = MeditationListView()
    lazy var disposeBag = DisposeBag()
    var collectionId: Int?
    
    var collection: CollectionDetail? {
        didSet {
            mainView.titleLabel.text = collection?.name
            mainView.descriptionLabel.text = collection?.description
            mainView.backgroundImage.kf.setImage(with: URL(string: collection?.fileImage ?? ""))
            mainView.tableView.reloadData()
            
            mainView.setUp()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .lightContent
        
        viewModel = MeditationListViewModel()
        viewModel?.superVc = self
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.moreButton.addTarget(self, action: #selector(moreTapped), for: .touchUpInside)
        mainView.playButton.addTarget(self, action: #selector(bigPlayTapped), for: .touchUpInside)
        
        bind()
    }
    
    @objc func moreTapped() {
        mainView.moreButton.isActive.toggle()
        mainView.descriptionLabel.snp.updateConstraints({
            $0.height.equalTo(
                mainView.moreButton.isActive ?
                    collection?.description?.height(withConstrainedWidth: mainView.descriptionLabel.frame.width, font: mainView.descriptionLabel.font) ?? 0 :
                    StaticSize.size(40)
            )
        })
        if !mainView.isUp {
            mainView.animateUp()
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.mainView.layoutIfNeeded()
        })
    }
    
    func bind() {
        viewModel?.collection.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.collection = object
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func bigPlayTapped() {
        guard let collection = collection else { return }
        let vc = MeditationDetailViewController(collection: collection, currentMeditation: 0)
        vc.mainView.backgroundImage.kf.setImage(with: URL(string: collection.fileImage ?? ""))
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MeditationListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection?.meditations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MeditationCell.reuseIdentifier, for: indexPath) as! MeditationCell
        cell.meditation = collection?.meditations?.map({ meditation in Meditation(meditationId: meditation.id, meditationName: meditation.name, meditationDescription: meditation.description_, meditationFileMaleVoice: meditation.fileMaleVoice, meditationFileFemaleVoice: meditation.fileFemaleVoice, collectionId: self.collection?.id, fileImage: self.collection?.fileImage, durationMale: meditation.durationMale, durationFemale: meditation.durationFemale) })[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let collection = collection, collection.meditations?[indexPath.row].fileMaleVoice != nil ||
                collection.meditations?[indexPath.row].fileFemaleVoice != nil else { return }
        let vc = MeditationDetailViewController(collection: collection, currentMeditation: indexPath.row)
        vc.mainView.backgroundImage.kf.setImage(with: URL(string: collection.fileImage ?? ""))
        navigationController?.pushViewController(vc, animated: true)
    }
}
