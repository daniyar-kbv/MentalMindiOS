//
//  ProfileMainView.swift
//  MentalMindiOS
//
//  Created by Daniyar on 06.12.2020.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher
import JTAppleCalendar

class ProfileMainView: BaseView {
    var types: [ProfileInfoCellType]
    let vc = UIApplication.topViewController() as? ProfileMainViewController
    var user = AppShared.sharedInstance.user {
        didSet {
            if let image = user?.profileImage {
                avatarView.kf.setImage(with: URL(string: image), for: .normal)
            } else {
                avatarView.setBackgroundImage(UIImage(named: "avatarPlaceholder"), for: .normal)
            }
        }
    }
    var level = AppShared.sharedInstance.level
    var needToSetUp = false
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: StaticSize.tabBarHeight, right: 0)
        view.delaysContentTouches = false
        return view
    }()
    
    lazy var stack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [mainContainer])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isLayoutMarginsRelativeArrangement = true
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    lazy var mainContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var avatarView: UIButton = {
        let view = UIButton()
        view.layer.cornerRadius = StaticSize.size(39)
        view.layer.masksToBounds = true
        view.imageView?.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var loginTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(14), weight: .bold)
        label.textColor = .customTextBlack
        label.text = "Логин:".localized
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(16), weight: .regular)
        label.textColor = .customTextBlack
        label.text = user?.email
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var loginStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [loginTitleLabel, loginLabel])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        view.spacing = StaticSize.size(5)
        return view
    }()
    
    lazy var instagramButton: GradientButton = {
        let view = GradientButton()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = StaticSize.size(15)
        return view
    }()
    
    lazy var instagramImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "instagram")
        view.isUserInteractionEnabled = false
        return view
    }()
    
    lazy var instagramLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(17), weight: .bold)
        label.textColor = .white
        label.text = "mentalmind.kz"
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var infoTableContainer: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = StaticSize.size(3)
        view.layer.shadowOffset = CGSize(width: 0, height: StaticSize.size(1))
        view.layer.shadowOpacity = 0.15
        return view
    }()
    
    lazy var infoTableView: UITableView = {
        let view = UITableView()
        view.register(ProfileMainInfoCell.self, forCellReuseIdentifier: ProfileMainInfoCell.reuseIdentifier)
        view.isScrollEnabled = false
        view.showsVerticalScrollIndicator = false
        view.rowHeight = StaticSize.size(44)
        view.layer.cornerRadius = StaticSize.size(10)
        view.contentInset = UIEdgeInsets(top: StaticSize.size(4), left: 0, bottom: StaticSize.size(4), right: 0)
        view.backgroundColor = .white
        view.separatorStyle = .none
        return view
    }()
    
    lazy var notificationsSwitch: UISwitch = {
        let view = UISwitch()
        view.onTintColor = .customGreen
        view.thumbTintColor = .white
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings() { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .authorized, .provisional, .ephemeral:
                    view.isOn = !(AppShared.sharedInstance.notificationsWeekdays.value?.isEmpty ?? true)
                default:
                    view.isOn = false
                }
            }
        }
        return view
    }()
    
    lazy var notificationsLabel: UILabel = {
        let label = UILabel()
        label.font = .montserrat(ofSize: StaticSize.size(20), weight: .medium)
        label.textColor = .customTextBlack
        label.text = "Напоминать о медитации".localized
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var levelItem: ProfileItemContainer = {
        let view = ProfileItemContainer()
        view.titleLabel.text = "Твой уровень".localized
        let levelView: LevelView = {
            let view = LevelView()
            view.type = .profile
            view.level = level
            return view
        }()
        view.setView(levelView)
        levelView.snp.makeConstraints({
            $0.height.equalTo(StaticSize.levelViewHeight)
        })
        return view
    }()
    
    lazy var calendarItem: ProfileItemContainer = {
        let view = ProfileItemContainer()
        view.titleLabel.text = "История".localized
        let calendarView: HistoryCalendar = {
            let view = HistoryCalendar()
            return view
        }()
        view.setView(calendarView)
        return view
    }()
    
    lazy var meditationsItem: ProfileItemContainer = {
        let view = ProfileItemContainer()
        view.titleLabel.text = "Мои любимые медитации".localized
        let meditationsView: FavoriteMeditationsView = {
            let view = FavoriteMeditationsView()
            view.superView = self
            return view
        }()
        view.setView(meditationsView)
        return view
    }()
    
    lazy var subscriptionItem: ProfileItemContainer = {
        let view = ProfileItemContainer()
        view.titleLabel.text = "Разблокируй безграничные возможности себя и приложения".localized
        let subscriptionView: SubscriptionView = {
            let view = SubscriptionView()
            return view
        }()
        view.setView(subscriptionView)
        return view
    }()
    
    lazy var signOutItem: ProfileItemContainer = {
        let view = ProfileItemContainer()
        let subscriptionView: SignOutView = {
            let view = SignOutView()
            return view
        }()
        view.setView(subscriptionView)
        return view
    }()
    
    lazy var bottomStack: UIStackView = {
        let view = UIStackView(arrangedSubviews: [levelItem, calendarItem, meditationsItem, subscriptionItem])
        view.axis = .vertical
        view.distribution = .equalSpacing
        view.alignment = .fill
        return view
    }()
    
    required init(types: [ProfileInfoCellType]) {
        self.types = types
        
        super.init(titleOnTop: false)
        
        backgroundColor = .white
        
        rightButton.setBackgroundImage(UIImage(named: "settings"), for: .normal)
        
        barStyle = .darkContent
        
        if user != nil && level != nil {
            setUp()
        } else {
            needToSetUp = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(titleOnTop: Bool = true) {
        fatalError("init(titleOnTop:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubViews([scrollView])
        
        scrollView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        scrollView.addSubview(stack)
        
        stack.snp.makeConstraints({
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        })

        mainContainer.addSubViews([avatarView, loginStack, instagramButton, infoTableContainer, notificationsSwitch, notificationsLabel, bottomStack])

        avatarView.snp.makeConstraints({
            $0.top.equalToSuperview().offset(StaticSize.size(14))
            $0.left.equalToSuperview().offset(StaticSize.size(32))
            $0.size.equalTo(StaticSize.size(78))
        })

        loginStack.snp.makeConstraints({
            $0.centerY.equalTo(avatarView)
            $0.left.equalTo(avatarView.snp.right).offset(StaticSize.size(16))
            $0.right.equalToSuperview().offset(-StaticSize.size(32))
        })

        instagramButton.snp.makeConstraints({
            $0.top.equalTo(avatarView.snp.bottom).offset(StaticSize.size(32))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.size(60))
        })

        instagramButton.addSubViews([instagramImage, instagramLabel])

        instagramImage.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(18))
            $0.centerY.equalToSuperview()
            $0.size.equalTo(StaticSize.size(24))
        })

        instagramLabel.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
        
        infoTableContainer.snp.makeConstraints({
            $0.top.equalTo(instagramButton.snp.bottom).offset(StaticSize.size(32))
            $0.left.right.equalToSuperview().inset(StaticSize.size(15))
            $0.height.equalTo(StaticSize.size(8) + (
                    infoTableView.rowHeight * CGFloat(types.count)
                )
            )
        })
        
        infoTableContainer.addSubViews([infoTableView])
        
        infoTableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        notificationsSwitch.snp.makeConstraints({
            $0.top.equalTo(infoTableContainer.snp.bottom).offset(StaticSize.size(32))
            $0.right.equalToSuperview().offset(-StaticSize.size(15))
            $0.width.equalTo(StaticSize.size(52))
            $0.height.equalTo(StaticSize.size(32))
        })
        
        notificationsLabel.snp.makeConstraints({
            $0.left.equalToSuperview().offset(StaticSize.size(15))
            $0.right.equalTo(notificationsSwitch.snp.left).offset(StaticSize.size(-15))
            $0.centerY.equalTo(notificationsSwitch)
        })
        
        bottomStack.snp.makeConstraints({
            $0.top.equalTo(notificationsSwitch.snp.bottom).offset(StaticSize.size(44))
            $0.left.right.bottom.equalToSuperview()
        })
    }
}
