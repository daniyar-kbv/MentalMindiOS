//
//  HistoryViewController.swift
//  MentalMindiOS
//
//  Created by Dan on 12/22/20.
//

import Foundation
import UIKit
import RxSwift

class HistoryViewController: InnerViewController<HistoryViewModel> {
    lazy var mainView = HistoryView()
    lazy var disposeBag = DisposeBag()
    
    var date: Date?
    var records: [HistoryRecord] = [] {
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
        
        statusBarStyle = .darkContent
        mainView.setTitle(date?.format(format: "d MMMM").capitalized ?? "")
        
        viewModel = HistoryViewModel()
        viewModel?.superVc = self
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        bind()
    }
    
    func bind() {
        viewModel?.records.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.records = object
            }
        }).disposed(by: disposeBag)
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.reuseIdentifier, for: indexPath) as! HistoryCell
        cell.record = records[indexPath.row]
        return cell
    }
}
