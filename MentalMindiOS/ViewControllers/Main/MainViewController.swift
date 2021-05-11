//
//  MainViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation
import UIKit
import RxSwift

class MainViewController: BaseViewController {
    lazy var mainView = MainView()
    lazy var viewModel = MainViewModel()
    lazy var disposeBag = DisposeBag()
    var gotData = false
    var currentListenersAmount: Int? {
        didSet {
            self.mainView.tableView.reloadData()
        }
    }
    var cells: [(key: TableCell<Any>, value: MainItemsType)] = [] {
        didSet {
            if gotData {
                self.mainView.tableView.reloadData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.setTitle("Главная".localized)
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        mainView.topButton.addTarget(self, action: #selector(topButtonTapped), for: .touchUpInside)
        
        viewModel.vc = self
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getData()
    }
    
    func bind() {
        viewModel.recommendations.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.addCell(of: .recommendation, with: object)
            }
        }).disposed(by: disposeBag)
        viewModel.collections.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.addCell(of: .collections, with: object)
            }
        }).disposed(by: disposeBag)
        viewModel.meditaions.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.addCell(of: .favorites, with: object)
            }
        }).disposed(by: disposeBag)
        viewModel.challenges.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.addCell(of: .challenges, with: object)
            }
        }).disposed(by: disposeBag)
        viewModel.courses.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.addCell(of: .courses, with: object)
            }
        }).disposed(by: disposeBag)
        viewModel.currentListenersAmount.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.currentListenersAmount = object
            }
        }).disposed(by: disposeBag)
        viewModel.gotData.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
                self.gotData = true
            }
        }).disposed(by: disposeBag)
        AppShared.sharedInstance.feelingSubject.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.viewModel.getRecommendations(separate: true)
            }
        }).disposed(by: disposeBag)
    }
    
    func addCell<T>(of type: MainItemsType, with items: [T]) {
        guard items.count > 0 else {
            if let index = cells.firstIndex(where: { $0.value == type }) {
                cells.remove(at: index)
            }
            return
        }
        guard !cells.contains(where: { $0.1 == type }) else {
            cells.first(where: { $0.1 == type })?.0.items = items
            return
        }
        var cells = self.cells
        let cell = TableCell<Any>(frame: .zero)
        switch type {
        case .recommendation:
            cell.type = .medium
            cell.titleLabel.text = "Мы рекомендуeм Вам".localized
        case .collections:
            cell.type = .medium
            cell.titleLabel.text = "Поток жизни".localized
        case .favorites:
            cell.type = .medium
            cell.titleLabel.text = "Любимое".localized
        case .challenges:
            cell.type = .challenge
            cell.titleLabel.text = "Осенний челлендж".localized
        case .courses:
            cell.type = .tall
            cell.titleLabel.text = "Онлайн обучение".localized
        }
        cell.items = items
        cells.append((key: cell, value: type))
        self.cells = cells.sorted(by: {
            $0.1.rawValue < $1.1.rawValue
        })
    }
    
    @objc func topButtonTapped() {
        navigationController?.pushViewController(FeelingsViewController(), animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if cells.count > 0 {
            count = cells.count + 1
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < cells.count {
            return cells[indexPath.row].key
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrentListenersCell.reuseIdentifier, for: indexPath) as! CurrentListenersCell
            cell.number.text = currentListenersAmount?.formattedWithSeparator
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if cells.count > 0 {
            if indexPath.row < cells.count {
                return cells[indexPath.row].0.type?.height ?? 0
            } else {
                return CollectionType.currentListeners.height
            }
        }
        return 0
    }
}
