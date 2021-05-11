//
//  FeelingsCell.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation
import UIKit
import SnapKit

class FeelingsCell: UICollectionViewCell {
    static let reuseIdentifier = "FeelingsCell"
    
    var feeling: Feeling? {
        didSet {
            titleLabel.text = feeling?.name
        }
    }
    var index: Int? {
        didSet {
            guard let index = index else { return }
            imageView.image = UIImage(named: "feeling-\(index)")
        }
    }
    
    lazy var container: TappableButton = {
        let view = TappableButton()
        view.backgroundColor = .white
        view.layer.cornerRadius = StaticSize.size(21)
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(16), weight: .regular)
        label.textColor = .customTextBlack
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([container])
        
        container.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.height.equalTo(StaticSize.size(42))
            $0.left.right.equalToSuperview().inset(StaticSize.size(6))
        })
        
        container.addSubViews([imageView, titleLabel])
        
        imageView.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(6))
            $0.centerY.equalToSuperview()
            $0.size.equalTo(StaticSize.size(30))
        })
        
        titleLabel.snp.makeConstraints({
            $0.left.equalTo(imageView.snp.right).offset(StaticSize.size(8))
            $0.right.equalToSuperview().offset(StaticSize.size(-8))
            $0.centerY.equalToSuperview()
        })
    }
}
