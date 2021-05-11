//
//  ChooseAuthViewController.swift
//  MentalMindiOS
//
//  Created by Daniyar on 11/29/20.
//

import Foundation
import UIKit
import GoogleSignIn
import FBSDKLoginKit
import VK_ios_sdk
import AuthenticationServices
import RxSwift

class ChooseAuthViewController: BaseViewController {
    lazy var authView = ChooseAuthView(titleOnTop: false)
    lazy var viewModel = ChooseAuthViewModel()
    lazy var disposeBag = DisposeBag()
    
    var authTypes: [AuthType] = [.email, .gmail, .facebook, .vk, .apple]
    lazy var loginButtonFb: FBLoginButton = {
        let view = FBLoginButton()
        view.permissions = ["public_profile", "email"]
        view.delegate = self
        return view
    }()
    
    let vkSDK = VKSdk.initialize(withAppId: "7630107")!
    
    override func loadView() {
        super.loadView()
        
        view = authView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statusBarStyle = .lightContent
        
        authView.setTitle("Войти".localized)
        authView.bottomButton.isHidden = false
        
        authView.tableView.delegate = self
        authView.tableView.dataSource = self
        
        authView.bottomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
        
        GIDSignIn.sharedInstance().clientID = "712578955819-7ppkqop0mf85l5kl2clmtirn15sn12ne.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self

        vkSDK.register(self)
        
        bind()
    }
    
    func bind() {
        viewModel.userSubject.subscribe(onNext: { user in
            DispatchQueue.main.async {
                AppShared.sharedInstance.user = user
                let vc = NavigationMenuBaseController()
                AppShared.sharedInstance.tabBarController = vc
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    @objc func buttonTapped(_ button: UIButton) {
        switch authTypes[button.tag] {
        case .email:
            let vc = AuthViewController(type: .login)
            navigationController?.pushViewController(vc, animated: true)
        case .gmail:
            GIDSignIn.sharedInstance()?.signIn()
        case .facebook:
            loginButtonFb.sendActions(for: .touchUpInside)
        case .vk:
            let scope = ["email", "access_token"]
            VKSdk.wakeUpSession(scope) { (state, error) in
                if state == .authorized {
                    print("authorized")
                }else {
                    VKSdk.authorize(scope)
                }
                return
            }
        case .apple:
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        default:
            break
        }
    }
    
    @objc func bottomButtonTapped() {
        let vc = AuthViewController(type: .register)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ChooseAuthViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChooseAuthCell.reuseIdentifier, for: indexPath) as! ChooseAuthCell
        cell.type = authTypes[indexPath.row]
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return cell
    }
}

extension ChooseAuthViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        viewModel.socialLogin(type: .gmail, token: user.authentication.idToken, email: nil, fullName: nil)
    }
}

extension ChooseAuthViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = result?.token?.tokenString else { return }
        viewModel.socialLogin(type: .facebook, token: token, email: nil, fullName: nil)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
}

extension ChooseAuthViewController: VKSdkDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print("vkSdkShouldPresent")
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print("vkSdkNeedCaptchaEnter")
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult?) {
        print("vkSdkAccessAuthorizationFinished")
        guard let token = result?.token?.accessToken, let email = result?.token?.email else {
            guard let token = result?.token?.accessToken else { return }
            viewModel.socialLogin(type: .vk, token: token, email: nil, fullName: nil)
            return
        }
        viewModel.socialLogin(type: .vk, token: token, email: email, fullName: nil)
    }
    
    func vkSdkUserAuthorizationFailed() {
        print("vkSdkUserAuthorizationFailed")
    }
    
    func vkSdkAuthorizationStateUpdated(with result: VKAuthorizationResult!) {
        print("vkSdkAuthorizationStateUpdated")
    }
    
    func vkSdkTokenHasExpired(_ expiredToken: VKAccessToken!) {
        print("vkSdkTokenHasExpired")
    }
    
    func vkSdkAccessTokenUpdated(_ newToken: VKAccessToken!, oldToken: VKAccessToken!) {
        print("vkSdkAccessTokenUpdated, new token: \(newToken), old token: \(oldToken)")
    }
}

extension ChooseAuthViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credential as ASAuthorizationAppleIDCredential:
            var fullName: String? = nil
            var email = credential.email
            if let firstName = credential.fullName?.givenName, let lastName = credential.fullName?.familyName {
                fullName = "\(firstName) \(lastName)"
            }
            let token = String(decoding:  credential.identityToken! , as: UTF8.self)
//            let pasteboard = UIPasteboard.general
//            pasteboard.string = token
            viewModel.socialLogin(type: .apple, token: token, email: email, fullName: fullName)
        case let passwordCredential as ASPasswordCredential:
            showAlert(title: passwordCredential.user)
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        showAlert(title: error.localizedDescription)
    }
}
