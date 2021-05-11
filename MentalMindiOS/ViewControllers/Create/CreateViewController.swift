//
//  CreateViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/3/20.
//

import Foundation
import UIKit
import RxSwift

class CreateViewController: BaseViewController {
    lazy var createView = CreateView()
    lazy var viewModel = CreateViewModel()
    lazy var disposeBag = DisposeBag()
    
    var cells: [(key: TableCell<Any>, value: CreateItemsType)] = [] {
        didSet {
            createView.tableView.reloadData()
        }
    }
    var preCells: [(key: TableCell<Any>, value: CreateItemsType)] = [] {
        didSet {
            guard types != nil && affirmations != nil else { return }
            cells = preCells
        }
    }
    var types: [(key: Type, value: [Collection])]?
    var affirmations: [Affirmation]?
    
    override func loadView() {
        super.loadView()
        
        view = createView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createView.setTitle("Созидай".localized)
        
        createView.tableView.delegate = self
        createView.tableView.dataSource = self
        
        viewModel.vc = self
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getData()
    }
    
    func bind() {
        viewModel.typesSubject.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.types = object
                for type in object {
                    self.addCell(of: .collection, with: type.value, type_: type.key)
                }
            }
        }).disposed(by: disposeBag)
        viewModel.affirmations.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.affirmations = object
                self.addCell(of: .affirmations, with: object)
            }
        }).disposed(by: disposeBag)
    }
    
    func addCell<T>(of type: CreateItemsType, with items: [T], type_: Type? = nil) {
        guard items.count > 0 else { return }
        guard !(cells.contains(where: { $0.1 == .affirmations }) && type_ == nil) else {
            cells.first(where: { $0.1 == .affirmations })?.0.items = items
            return
        }
        guard !(cells.contains(where: { $0.1 == .collection && $0.0.type_?.id == type_?.id }) && type_ != nil) else {
            cells.first(where: { $0.1 == .collection && $0.0.type_?.id == type_?.id })?.0.items = items
            return
        }
        var cells = preCells
        let cell = self.createView.tableView.dequeueReusableCell(withIdentifier: TableCell<Any>().identifier) as! TableCell<Any>
        switch type {
        case .collection:
            cell.type = .medium
            cell.titleLabel.text = type_?.name
            cell.type_ = type_
        case .affirmations:
            cell.type = .affirmations
            cell.titleLabel.text = "Аффирмации".localized
        }
        cell.items = items
        cells.append((key: cell, value: type))
        self.preCells = cells.sorted(by: {
            $0.1.rawValue < $1.1.rawValue
        })
    }
}

extension CreateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row].key
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cells[indexPath.row].0.type?.height ?? 0
    }
}
