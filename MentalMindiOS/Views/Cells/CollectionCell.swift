//
//  MediumCellectionCell.swift
//  MentalMindiOS
//
//  Created by Daniyar on 12/1/20.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class CollectionCell<T>: UICollectionViewCell {
    var item: T? {
        didSet {
            var url: String?
            if let item = item as? Collection {
                url = item.fileImage
                titleLabel.text = item.name
                subtitleLabel.text = item.description
            } else if let item = item as? Meditation {
                url = item.fileImage
                titleLabel.text = item.meditationName
                subtitleLabel.text = item.meditationName
            } else if let item = item as? Challenge {
                url = item.fileImage
                titleLabel.text = item.name
                subtitleLabel.text = item.description
            } else if let item = item as? Course {
                url = item.fileImage
            } else if let item = item as? Affirmation {
                url = item.fileImage
                affirmationTitle.text = item.name
            }
            guard let url_ = URL(string: url ?? "") else { return }
            KingfisherManager.shared.retrieveImage(with: url_) { result in
                let image = try? result.get().image
                self.imageView.image = image
            }
//            imageView.kf.setImage(with: URL(string: url ?? ""))
        }
    }
    
    var type: CollectionType? {
        didSet {
            setUp()
        }
    }
    
    lazy var style: CellContentStyle = .darkContent {
        didSet {
            switch style {
            case .darkContent:
                titleLabel.textColor = .customTextBlack
                subtitleLabel.textColor = .customTextBlack
            case .lightContent:
                titleLabel.textColor = .white
                subtitleLabel.textColor = .white
            }
        }
    }
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = type?.placeholderImage
        view.layer.cornerRadius = StaticSize.size(15)
        view.layer.masksToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(13), weight: .bold)
        label.textColor = .customTextBlack
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(13), weight: .regular)
        label.textColor = .customTextBlack
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    lazy var challengeContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = StaticSize.size(15)
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var challengeLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(11), weight: .medium)
        label.textColor = .white
        label.adjustsFontSizeToFitWidth = true
        label.text = "Ежедневный челлендж".localized
        return label
    }()
    
    lazy var challengeImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "challengeSmall")
        return view
    }()
    
    lazy var affirmationContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    lazy var affirmationTitle: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(16), weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        challengeContainer.addGradientBackground(colors: [UIColor.customBlue.withAlphaComponent(0.75), UIColor.customGreen.withAlphaComponent(0.75)], direction: .leftToRight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func getReuseIdenifier() -> String {
        return "CollectionCell"
    }
    
    func setUp() {
        switch type {
        case .medium, .wide, .challenge:
            contentView.addSubViews([imageView, titleLabel, subtitleLabel])
            
            imageView.snp.remakeConstraints({
                $0.top.left.equalToSuperview()
                $0.right.equalToSuperview().offset(-StaticSize.size(8))
                $0.height.equalTo(StaticSize.size(141))
            })
            
            titleLabel.snp.remakeConstraints({
                $0.top.equalTo(imageView.snp.bottom).offset(StaticSize.size(8))
                $0.left.right.equalTo(imageView)
            })
            
            subtitleLabel.snp.remakeConstraints({
                $0.top.equalTo(titleLabel.snp.bottom).offset(StaticSize.size(4))
                $0.left.right.equalTo(imageView)
            })
            
            if type == .challenge {
                imageView.addSubViews([challengeContainer])
                
                challengeContainer.snp.makeConstraints({
                    $0.bottom.left.right.equalToSuperview()
                    $0.height.equalTo(StaticSize.size(30))
                })
                
                challengeContainer.addSubViews([challengeImage, challengeLabel])
                
                challengeImage.snp.makeConstraints({
                    $0.right.equalToSuperview().offset(-StaticSize.size(12))
                    $0.centerY.equalToSuperview()
                    $0.size.equalTo(StaticSize.size(14))
                })
                
                challengeLabel.snp.makeConstraints({
                    $0.left.equalToSuperview().offset(StaticSize.size(12))
                    $0.centerY.equalToSuperview()
                    $0.right.equalTo(challengeImage.snp.left).offset(-StaticSize.size(12))
                })
            }
        case .tall, .affirmations:
            contentView.addSubViews([imageView])
            
            imageView.snp.remakeConstraints({
                $0.top.left.equalToSuperview()
                $0.bottom.equalToSuperview().offset(-StaticSize.size(18))
                $0.right.equalToSuperview().offset(-StaticSize.size(8))
            })
            
            if type == .affirmations {
                imageView.addSubViews([affirmationContainer, affirmationTitle])
                
                affirmationContainer.snp.makeConstraints({
                    $0.edges.equalToSuperview()
                })
                
                affirmationTitle.snp.makeConstraints({
                    $0.centerY.equalToSuperview()
                    $0.left.right.equalToSuperview().inset(StaticSize.size(15))
                })
            }
        default:
            break
        }
    }
}
