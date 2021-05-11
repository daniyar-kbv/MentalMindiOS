//
//  TariffCell.swift
//  MentalMindiOS
//
//  Created by Dan on 12/23/20.
//

import Foundation
import UIKit
import StoreKit

class TariffCell: UICollectionViewCell {
    static let reuseIdentifier = "TariffCell"
    
    var type: ViewType? {
        didSet {
            mainContainer.image = type?.backgroundImage
            bottomButton.setBackgroundImage(type?.buttonImage, for: .normal)
        }
    }
    var tariffProduct: (key: Tariff, value: SKProduct?)? {
        didSet {
            priceLabel.text = Int(truncating: tariffProduct?.value?.price ?? 0).formattedWithSeparator
            descriptionLabel.text = tariffProduct?.key.description_
            nameLabel.text = tariffProduct?.key.name
        }
    }
    var onButtonTapped: ((_ cell: TariffCell)->())?
    
    lazy var mainContainer: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.contentMode = .scaleToFill
        return view
    }()
    
    lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.font = .montserrat(ofSize: StaticSize.size(27), weight: .regular)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    lazy var currencyLabel: UILabel = {
        let view = UILabel()
        view.font = .montserrat(ofSize: StaticSize.size(18.4), weight: .regular)
        view.textColor = .white
        view.text = "₸"
        return view
    }()
    
    lazy var priceStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [priceLabel, currencyLabel])
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.alignment = .top
        view.spacing = StaticSize.size(4)
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = .montserrat(ofSize: StaticSize.size(12), weight: .regular)
        view.textColor = .white
        view.numberOfLines = 0
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = .montserrat(ofSize: StaticSize.size(12), weight: .semiBold)
        view.textColor = .white
        view.textAlignment = .center
        return view
    }()
    
    lazy var bottomButton: UIButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    @objc func buttonTapped() {
        onButtonTapped?(self)
    }
    
    func setUp() {
        contentView.addSubViews([mainContainer, bottomButton])
        
        mainContainer.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.height.equalTo(StaticSize.size(300))
            $0.width.equalToSuperview()
        })
        
        bottomButton.snp.makeConstraints({
            $0.centerY.equalTo(mainContainer.snp.bottom)
            $0.centerX.equalTo(mainContainer)
            $0.width.equalTo(StaticSize.size(120))
            $0.height.equalTo(StaticSize.size(35))
            $0.bottom.equalToSuperview()
        })
        
        mainContainer.addSubViews([priceStack, descriptionLabel, nameLabel])
        
        priceStack.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(60))
            $0.centerX.equalToSuperview()
        })
        
        descriptionLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview().offset(StaticSize.size(30))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
        
        nameLabel.snp.makeConstraints({
            $0.bottom.equalToSuperview().offset(-StaticSize.size(33))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum ViewType: CaseIterable {
        case pink
        case blue
        case violet
        
        var backgroundImage: UIImage {
            switch self {
            case .pink:
                return UIImage(named: "purchseBackPink")!
            case .blue:
                return UIImage(named: "purchseBackBlue")!
            case .violet:
                return UIImage(named: "purchseBackViolet")!
            }
        }
        
        var buttonImage: UIImage? {
            switch self {
            case .pink:
                return UIImage(named: "subscribePurple")
            case .blue:
                return UIImage(named: "subscribeBlue")
            case .violet:
                return UIImage(named: "subscribeViolet")
            }
        }
    }
}
