//
//  EndPoint.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import Alamofire

enum APIPoint {
    case login(email: String, password: String)
    case socialLogin(type: AuthType?, token: String, email: String?, fullName: String?)
    case register(email: String, password: String)
    case passwordRestore(email: String)
    case subscriptionStatus
    case feelings
    case collections(type: Int, forFeeling: Int?, tags: Int?, page: Int)
    case favoriteMeditaions(page: Int)
    case challenges(page: Int)
    case challengeDetail(id: Int)
    case courses(page: Int)
    case tags(page: Int)
    case types(page: Int)
    case affirmations(page: Int)
    case collectionDetail(id: Int)
    case favoriteMeditationsAdd(meditationId: Int, collectionId: Int)
    case favoriteMeditationsDelete(meditationId: Int, collectionId: Int)
    case rateMeditation(star: Int, meditation: Int)
    case me
    case levelDetail(id: Int)
    case faq
    case updateUser(profileImage: URL? = nil, fullName: String? = nil, birthday: String? = nil, language: Language? = nil, country: String? = nil, city: String? = nil, fcmToken: String? = nil)
    case changePassword(oldPassword: String, newPassword: String)
    case help(text: String)
    case promocode(promocode: String)
    case levels
    case sendHistory(meditation: Int, listenedSeconds: Int)
    case getHistory(date: Date)
    case tariffs
    case meditationDetail(id: Int)
    case affiramtionDetail(id: Int)
    case payment(receipt: String, tariffId: Int)
    case countries
    case currentListeners
}

extension APIPoint: EndPointType {
    var path: String {
        switch self {
        case .login:
            return "/users/login/"
        case .socialLogin:
            return "/users/social_login/"
        case .register:
            return "/users/register/"
        case .passwordRestore:
            return "/users/password_recovery/"
        case .subscriptionStatus:
            return "/users/me/subscription_status/"
        case .feelings:
            return "/feelings/"
        case .collections:
            return "/collections/"
        case .favoriteMeditaions:
            return "/users/me/favorites/"
        case .challenges:
            return "/challenges/"
        case .challengeDetail(let id):
            return "/challenges/\(id)"
        case .courses:
            return "/courses/"
        case .tags:
            return "/tags/"
        case .types:
            return "/collection_types/"
        case .affirmations:
            return "/affirmations/"
        case .collectionDetail(let id):
            return "/collections/\(id)"
        case .favoriteMeditationsAdd:
            return "/users/me/favorites/"
        case .favoriteMeditationsDelete:
            return "/users/me/favorites/delete"
        case .rateMeditation:
            return "/rating/"
        case .me:
            return "/users/me/"
        case .levelDetail(let id):
            return "/levels/\(id)"
        case .faq:
            return "/faqs/"
        case .updateUser:
            return "/users/me/"
        case .changePassword:
            return "/users/password_reset/"
        case .help:
            return "/help/"
        case .promocode:
            return "/promocode/"
        case .levels:
            return "/levels/"
        case .sendHistory, .getHistory:
            return "/history/"
        case .tariffs:
            return "/payments/tariffs/"
        case .meditationDetail(let id):
            return "/meditations/\(id)"
        case .affiramtionDetail(let id):
            return "/affirmations/\(id)"
        case .payment:
            return "/payments/ios/"
        case .countries:
            return "/countries_and_cities/"
        case .currentListeners:
            return "/online_listeners/"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .socialLogin, .login, .register, .passwordRestore, .favoriteMeditationsAdd, .favoriteMeditationsDelete, .rateMeditation, .help, .promocode, .sendHistory, .payment:
            return .post
        case .updateUser, .changePassword:
            return .put
        default:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [
                "email": email,
                "password": password,
                "firebase_token": AppShared.sharedInstance.fcmToken ?? ""
            ]
        case .socialLogin(let type, let token, let email, let fullName):
            var parameters: Parameters = [
                "token": token
            ]
            if let type = type?.apiName {
                parameters["type"] = type
            }
            if let email = email {
                parameters["email"] = email
            }
            if let fullName = fullName {
                parameters["full_name"] = fullName
            }
            if let fcmToken = AppShared.sharedInstance.fcmToken {
                parameters["firebase_token"] = fcmToken
            }
            return [
                "social_info": parameters
            ]
        case .register(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        case .passwordRestore(let email):
            return [
                "email": email
            ]
        case .collections(let type, let forFeeling, let tags, let page):
            var parameters: Parameters = [
                "type": type,
                "page": page
            ]
            if let forFeeling = forFeeling {
                parameters["for_feeling"] = forFeeling
            }
            if let tags = tags {
                parameters["tags"] = tags
            }
            return parameters
        case .favoriteMeditaions(let page), .challenges(let page), .courses(let page), .tags(let page), .types(let page), .affirmations(let page):
            return [
                "page": page
            ]
        case .favoriteMeditationsAdd(let meditationId, let collectionId), .favoriteMeditationsDelete(let meditationId, let collectionId):
            return [
                "meditation": meditationId,
                "collection": collectionId
            ]
        case .rateMeditation(let star, let meditation):
            return [
                "star": star,
                "meditation": meditation
            ]
        case .updateUser(let profileImage, let fullName, let birthday, let language, let country, let city, let fcmToken):
            var parameters: Parameters = [:]
            if let profileImage = profileImage {
                parameters["profile_image"] = profileImage
            }
            if let fullName = fullName {
                parameters["full_name"] = fullName
            }
            if let birthday = birthday {
                parameters["birthday"] = birthday
            }
            if let language = language {
                parameters["language"] = language.rawValue
            }
            if let country = country {
                parameters["country"] = country
            }
            if let city = city {
                parameters["city"] = city
            }
            if let fcmToken = fcmToken {
                parameters["firebase_token"] = fcmToken
            }
            return parameters
        case .changePassword(let oldPassword, let newPassword):
            return [
                "old_password": oldPassword,
                "new_password": newPassword
            ]
        case .help(let text):
            return [
                "text": text
            ]
        case .promocode(let promocode):
            return [
                "promocode": promocode
            ]
        case .sendHistory(let meditation, let listenedSeconds):
            return [
                "meditation": meditation,
                "listened_seconds": listenedSeconds
            ]
        case .getHistory(let date):
            return [
                "date": date.format(format: "yyyy-MM-dd")
            ]
        case .payment(let receipt, let tariffId):
            return [
                "receipt_data": receipt,
                "tariff_id": tariffId,
                "dev": Config.isDevelopment
            ]
        default:
            return nil
        }
    }
    
    var encoding: Encoder.Encoding {
        switch self {
        case .collections, .challenges, .favoriteMeditaions, .courses, .tags, .types, .affirmations, .getHistory:
            return .urlEncoding
        default:
            return .jsonEncoding
        }
    }
    
    var additionalHeaders: HTTPHeaders? {
        switch self {
        default:
            return nil
        }
    }
    
    var baseURL: URL {
        switch self {
        case .login, .register, .passwordRestore, .socialLogin, .subscriptionStatus, .favoriteMeditationsAdd, .favoriteMeditationsDelete, .updateUser, .changePassword:
            return URL(string: "https://server.mentalmind.kz")!
        case .collections, .favoriteMeditaions, .collectionDetail, .meditationDetail:
            return URL(string: "https://server.mentalmind.kz/api/v3")!
        default:
            return URL(string: "https://server.mentalmind.kz/api/v2")!
        }
    }
    
    var header: HTTPHeaders? {
        switch self {
        case .login, .register, .passwordRestore, .socialLogin:
            return [
                "Accept-Language": ModuleUserDefaults.getLanguage().rawValue
            ]
        default:
            return [
                "Accept-Language": ModuleUserDefaults.getLanguage().rawValue,
                "Authorization": "Token \(ModuleUserDefaults.getToken() ?? "")"
            ]
        }
    }
    
    var showLoader: Bool {
        switch self {
        case .subscriptionStatus, .collections, .challenges, .courses, .favoriteMeditaions, .tags, .types, .affirmations, .me, .levelDetail, .sendHistory, .tariffs, .currentListeners:
            return false
        default:
            return true
        }
    }
}
