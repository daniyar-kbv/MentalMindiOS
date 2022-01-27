//
//  LevelsViewController.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation
import UIKit
import RxSwift

class LevelsViewController: InnerViewController<LevelsViewModel> {
    lazy var mainView = LevelsView()
    lazy var disposeBag = DisposeBag()
    
    var levels: [Level] = [] {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.setTitle("Описание уровней".localized)
        statusBarStyle = .darkContent
        viewModel = LevelsViewModel()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        bind()
    }
    
    func bind() {
        viewModel?.levels.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.levels = object
            }
        }).disposed(by: disposeBag)
    }
}

extension LevelsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LevelCell.reuseIdentifier, for: indexPath) as! LevelCell
        cell.level = levels[indexPath.row]
        return cell
    }
}
