//
//  PremiumPurchaseViewController.swift
//  MentalMindiOS
//
//  Created by Dan on 12/23/20.
//

import Foundation
import UIKit
import RxSwift
import StoreKit

class PremiumPurchaseViewController: BaseViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    lazy var mainView = PremiumPurchaseView()
    lazy var viewModel = PremiumPurchaseViewModel()
    lazy var disposeBag = DisposeBag()
    
    var loader: Loader?
    var cellTypes =  TariffCell.ViewType.allCases
    var tariffs: [Tariff] = [] {
        didSet {
            self.fetchProducts()
        }
    }
    var products: [SKProduct]? {
        didSet {
            self.loader?.setProgress(100)
            tariffsProducts = tariffs.map({ tariff in
                (
                    key: tariff,
                    value: products?.first(where: { product in
                        product.productIdentifier == tariff.productId
                    })
                )
            })
        }
    }
    var tariffsProducts: [(key: Tariff, value: SKProduct?)] = [] {
        didSet {
            mainView.collectionView.reloadData()
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
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loader = Loader.show(mainView)
        viewModel.getTariffs()
    }
    
    func bind() {
        viewModel.tariffsResponse.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.loader?.setProgress(20)
                self.tariffs = object?.data?.results ?? []
            }
        }).disposed(by: disposeBag)
        viewModel.paymentResponse.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.showAlert(
                    title: "Покупка успешно завершена".localized,
                    actions: [(
                        key: "Ок".localized,
                        value: { action in
                            AppShared.sharedInstance.navigationController.popViewController(animated: true)
                            AppShared.sharedInstance.navigationController.popViewController(animated: false)
                            (UIApplication.topViewController() as? ProfileMainViewController)?.mainView.scrollView.scrollToTop(animated: true)
                        }
                    )]
                )
            }
        }).disposed(by: disposeBag)
    }
    
    func makePayment(_ cell: TariffCell) {
        guard let product = cell.tariffProduct?.value else { return }
        DispatchQueue.main.async {
            if SKPaymentQueue.canMakePayments() {
                let payment = SKPayment(product: product)
                SKPaymentQueue.default().add(self)
                SKPaymentQueue.default().add(payment)
            }
        }
    }
    
    func fetchProducts() {
        let request = SKProductsRequest(productIdentifiers: Set(tariffs.map({ $0.productId ?? "" })))
//        let request = SKProductsRequest(productIdentifiers: ["mentalmind.kz.threemonth"])
        request.delegate = self
        request.start()
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        DispatchQueue.main.async {
            self.products = response.products
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if [SKPaymentTransactionState.purchased, SKPaymentTransactionState.restored, SKPaymentTransactionState.failed, SKPaymentTransactionState.deferred].contains(transaction.transactionState) {
            }
            switch transaction.transactionState {
            case .purchasing:
                break
            case .purchased, .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                guard let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
                    FileManager.default.fileExists(atPath: appStoreReceiptURL.path) else {
                        return
                }
                loader = Loader.show(mainView)
                do {
                    let rawReceiptData = try Data(contentsOf: appStoreReceiptURL)
                    let receiptData = rawReceiptData.base64EncodedString()
                    guard let tariffId = tariffs.first(where: { $0.productId == transaction.payment.productIdentifier })?.id else { return }
                    viewModel.payment(receipt: receiptData, tariffId: tariffId)
                } catch {
                    loader?.setProgress(100)
                    showAlert(title: error.localizedDescription)
                }
            case .failed, .deferred:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
            default:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
            }
        }
    }
}

extension PremiumPurchaseViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tariffsProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TariffCell.reuseIdentifier, for: indexPath) as! TariffCell
        cell.type = cellTypes[indexPath.item]
        cell.tariffProduct = tariffsProducts[indexPath.item]
        cell.onButtonTapped = makePayment(_:)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: StaticSize.size(148), height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return StaticSize.size(15)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
