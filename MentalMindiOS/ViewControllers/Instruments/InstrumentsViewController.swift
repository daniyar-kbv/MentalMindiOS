//
//  InstrumentsViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/3/20.
//

import Foundation
import UIKit
import RxSwift

class InstrumentsViewController: BaseViewController {
    lazy var mainView = InstrumentsView()
    lazy var viewModel = InstrumentsViewModel()
    lazy var disposeBag = DisposeBag()
    
    var items: [(key: Tag, value: [Collection])] = [] {
        didSet {
            loadCells()
        }
    }
    
    var cells: [TableCell<Any>] = [] {
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
        
        statusBarStyle = .lightContent
        
        mainView.setTitle("Инструменты".localized)
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        bind()
        
        viewModel.vc = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getTags()
    }
    
    func loadCells() {
        self.cells = items.map({
            let cell = mainView.tableView.dequeueReusableCell(withIdentifier: TableCell<Any>().identifier) as! TableCell<Any>
            cell.titleLabel.text = $0.0.name
            cell.type = .medium
            cell.style = .lightContent
            cell.items = $0.value
            return cell
        })
    }
    
    func bind() {
        viewModel.tagsSubject.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.items = object
            }
        }).disposed(by: disposeBag)
    }
}

extension InstrumentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CollectionType.medium.height
    }
}


