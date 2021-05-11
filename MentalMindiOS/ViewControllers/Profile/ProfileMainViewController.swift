//
//  ProfileMainViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 06.12.2020.
//

import Foundation
import UIKit
import RxSwift
import Kingfisher

class ProfileMainViewController: BaseViewController {
    lazy var mainView = ProfileMainView(types: infoTableDelegate.types)
    lazy var viewModel = ProfileMainViewModel()
    lazy var profileViewModel = UpdateProfileViewModel()
    lazy var disposeBag = DisposeBag()
    lazy var infoTableDelegate = InfoTableDelegate()
    lazy var imagePicker = UIImagePickerController()
    
    var user: User? {
        didSet {
            mainView.user = user
            AppShared.sharedInstance.user = user
            mainView.meditationsItem.isHidden = user?.favoriteMeditations?.isEmpty ?? true
            var subscriptionText = ""
            if user?.getIsPreimium() ?? false {
                if user?.isPremium ?? false {
                    subscriptionText = "\("Ваш тариф:".localized) \("Премиум аккаунт".localized)"
                } else if user?.isPaid ?? false {
                    subscriptionText = "\("Ваш тариф:".localized) \(user?.tariff?.name ?? "")\n\("Действует до:".localized) \(user?.subsExpiryDate?.toDate(format: "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ")?.format(format: "dd.mm.yy") ?? "")"
                } else if user?.isTrial ?? false {
                    subscriptionText = "\("Ваш тариф:".localized) \("Пробный, трехдневный премиум доступ".localized)"
                }
            } else {
                subscriptionText = "Разблокируй безграничные возможности себя и приложения".localized
            }
            mainView.subscriptionItem.titleLabel.text = subscriptionText
            mainView.subscriptionItem.contentView.isHidden = user?.getIsPreimium() ?? false
        }
    }
    var level: Level? {
        didSet {
            mainView.level = level
            AppShared.sharedInstance.level = level
        }
    }
    
    override func loadView() {
        super.loadView()
        
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.setTitle("Профиль".localized)
        
        mainView.infoTableView.delegate = infoTableDelegate
        mainView.infoTableView.dataSource = infoTableDelegate
        
        mainView.rightButton.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        mainView.avatarView.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        mainView.notificationsSwitch.addTarget(self, action: #selector(checkNotifications), for: .valueChanged)
        mainView.instagramButton.addTarget(self, action: #selector(openInstagram), for: .touchUpInside)
        
        viewModel.vc = self
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getUserData()
    }
    
    func bind() {
        viewModel.user.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.user = object
            }
        }).disposed(by: disposeBag)
        viewModel.level.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.level = object
            }
        }).disposed(by: disposeBag)
        viewModel.gotData.subscribe(onNext: { object in
            DispatchQueue.main.async {
                if self.mainView.needToSetUp {
                    self.mainView.setUp()
                }
            }
        }).disposed(by: disposeBag)
        profileViewModel.user.subscribe(onNext: { object in
            DispatchQueue.main.async {
                self.user = object
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func openInstagram() {
        guard let url = URL(string: "instagram://user?username=mentalmind.kz") else { return }
        UIApplication.shared.open(url)
    }
    
    @objc func checkNotifications() {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings() { settings in
            switch settings.authorizationStatus {
            case .authorized, .provisional, .ephemeral:
                self.openNotifications()
            case .notDetermined:
                center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if let error = error {
                        self.showAlert(title: error.localizedDescription)
                    } else {
                        if granted {
                            self.openNotifications()
                        } else {
                            self.showNoificationsAlert()
                        }
                    }
                }
            default:
                self.showNoificationsAlert()
            }
        }
    }
    
    func showNoificationsAlert() {
        DispatchQueue.main.async {
            self.mainView.notificationsSwitch.setOn(false, animated: true)
            self.showAlert(
                title: "Вы не дали приложению разрешение на отправку пуш уведомлений".localized,
                messsage: "Что-бы получать уведомления, перейдите в настройки и дайте разрешение на отправку пуш уведомлений".localized,
                actions: [
                    (
                        key: "Назад".localized,
                        value: { action in
                            
                        }
                    ),
                    (
                        key: "Настройки".localized,
                        value: { action in
                            UIApplication.openAppSettings()
                        }
                    )
                ]
            )
        }
    }
    
    func openNotifications() {
        DispatchQueue.main.async {
            let vc = NotificationsViewController()
            vc.superVc = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func openImagePicker() {
        PhotoLibraryPermissionManager.isPermitted() {
            if $0 && UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                DispatchQueue.main.async {
                    self.imagePicker.delegate = self
                    self.imagePicker.sourceType = .savedPhotosAlbum
                    self.imagePicker.allowsEditing = false

                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func openSettings() {
        navigationController?.pushViewController(UpdateProfileViewController(), animated: true)
    }
}

class InfoTableDelegate: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var types: [ProfileInfoCellType] = [.faq, .help]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileMainInfoCell.reuseIdentifier, for: indexPath) as! ProfileMainInfoCell
        cell.type = types[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch types[indexPath.row] {
        case .faq:
            AppShared.sharedInstance.navigationController?.pushViewController(FAQViewController(), animated: true)
        case .help:
            AppShared.sharedInstance.navigationController?.pushViewController(HelpViewController(), animated: true)
        case .language:
            AppShared.sharedInstance.navigationController?.pushViewController(ChangeLanugageViewController(), animated: true)
        case .promocode:
            AppShared.sharedInstance.navigationController?.pushViewController(PromocodeViewController(), animated: true)
        }
    }
}

extension ProfileMainViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileViewModel.updateProfile(profileImage: info[.imageURL] as? URL)
        dismiss(animated: true, completion: nil)
    }
}

