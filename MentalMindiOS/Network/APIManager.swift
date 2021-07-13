//
//  APIManager.swift
//  Samokat
//
//  Created by Daniyar on 7/14/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation

struct APIManager {
    static let shared = APIManager()
    let router = MyRouter<APIPoint>()
    
    func login(email: String, password: String, completion: @escaping(_ error:String?,_ module: LoginResponse?)->()) {
        router.request(.login(email: email, password: password), returning: LoginResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func socialLogin(type: AuthType?, token: String, email: String?, fullName: String?, completion: @escaping(_ error:String?,_ module: LoginResponse?)->()) {
        router.request(.socialLogin(type: type, token: token, email: email, fullName: fullName), returning: LoginResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func register(email: String, password: String, completion: @escaping(_ error:String?,_ module: RegisterResponse?)->()) {
        router.request(.register(email: email, password: password), returning: RegisterResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func restorePassword(email: String, completion: @escaping(_ error:String?,_ module: PasswordRestoreResponse?)->()) {
        router.request(.passwordRestore(email: email), returning: PasswordRestoreResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func subscriptionStatus(completion: @escaping(_ error:String?,_ module: SubscriptionStatusResponse?)->()) {
        router.request(.subscriptionStatus, returning: SubscriptionStatusResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func feelings(completion: @escaping(_ error:String?,_ module: FeelingsResponse?)->()) {
        router.request(.feelings, returning: FeelingsResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func collections(type: Int, forFeeling: Int? = nil, tags: Int? = nil, page: Int = 1, completion: @escaping(_ error:String?,_ module: CollectionsResponse?)->()) {
        router.request(.collections(type: type, forFeeling: forFeeling, tags: tags, page: page), returning: CollectionsResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func favoriteMeditaions(page: Int = 1, completion: @escaping(_ error:String?,_ module: FavoriteMeditationsResponse?)->()) {
        router.request(.favoriteMeditaions(page: page), returning: FavoriteMeditationsResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func challenges(page: Int = 1, completion: @escaping(_ error:String?,_ module: ChallengesResponse?)->()) {
        router.request(.challenges(page: page), returning: ChallengesResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func challengeDetail(id: Int, completion: @escaping(_ error: String?,_ module: ChallengeDetailResponse?)->()) {
        router.request(.challengeDetail(id: id), returning: ChallengeDetailResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func courses(page: Int = 1, completion: @escaping(_ error:String?,_ module: CoursesResponse?)->()) {
        router.request(.courses(page: page), returning: CoursesResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func tags(page: Int = 1, completion: @escaping(_ error:String?,_ module: TagsResponse?)->()) {
        router.request(.tags(page: page), returning: TagsResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func types(page: Int = 1, completion: @escaping(_ error:String?,_ module: TypesResponse?)->()) {
        router.request(.types(page: page), returning: TypesResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func affirmations(page: Int = 1, completion: @escaping(_ error:String?,_ module: AffirmationsResponse?)->()) {
        router.request(.affirmations(page: page), returning: AffirmationsResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func collectionDetail(id: Int, completion: @escaping(_ error:String?,_ module: CollectionDetailResponse?)->()) {
        router.request(.collectionDetail(id: id), returning: CollectionDetailResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func favoriteMeditationsAdd(meditationId: Int, collectionId: Int, completion: @escaping(_ error:String?,_ module: FavoriteAddResponse?)->()) {
        router.request(.favoriteMeditationsAdd(meditationId: meditationId, collectionId: collectionId), returning: FavoriteAddResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func favoriteMeditationsDelete(meditationId: Int, collectionId: Int, completion: @escaping(_ error:String?,_ module: FavoriteDeleteResponse?)->()) {
        router.request(.favoriteMeditationsDelete(meditationId: meditationId, collectionId: collectionId), returning: FavoriteDeleteResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func rateMeditation(star: Int, meditation: Int, completion: @escaping(_ error:String?,_ module: RateMeditationResponse?)->()) {
        router.request(.rateMeditation(star: star, meditation: meditation), returning: RateMeditationResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func me(completion: @escaping(_ error: String?,_ module: MeResponse?)->()) {
        router.request(.me, returning: MeResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func myLevel(id: Int, completion: @escaping(_ error: String?,_ module: MyLevelResponse?)->()) {
        router.request(.levelDetail(id: id), returning: MyLevelResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func faq(completion: @escaping(_ error: String?,_ module: FAQResponse?)->()) {
        router.request(.faq, returning: FAQResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func updateProfile(profileImage: URL? = nil, fullName: String? = nil, birthday: String? = nil, language: Language? = nil, country: String? = nil, city: String? = nil, fcmToken: String? = nil, completion: @escaping(_ error: String?,_ module: MeResponse?)->()) {
        router.upload(.updateUser(profileImage: profileImage, fullName: fullName, birthday: birthday, language: language, country: country, city: city, fcmToken: fcmToken), returning: MeResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func changePassword(oldPassword: String, newPassword: String, completion: @escaping(_ error: String?,_ module: SuccessResponse?)->()) {
        router.request(.changePassword(oldPassword: oldPassword, newPassword: newPassword), returning: SuccessResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func help(text: String, completion: @escaping(_ error: String?,_ module: SuccessResponse?)->()) {
        router.request(.help(text: text), returning: SuccessResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func promocode(promocode: String, completion: @escaping(_ error: String?,_ module: PromocodeResponse?)->()) {
        router.request(.promocode(promocode: promocode), returning: PromocodeResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func levels(completion: @escaping(_ error: String?,_ module: LevelsResponse?)->()) {
        router.request(.levels, returning: LevelsResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func sendHistory(meditation: Int, listenedSeconds: Int, completion: @escaping(_ error: String?,_ module: SendHistoryResponse?)->()) {
        router.request(.sendHistory(meditation: meditation, listenedSeconds: listenedSeconds), returning: SendHistoryResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func getHistory(date: Date, completion: @escaping(_ error: String?,_ module: GetHistoryResponse?)->()) {
        router.request(.getHistory(date: date), returning: GetHistoryResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func tariffs(completion: @escaping(_ error: String?,_ module: TariffsResponse?)->()) {
        router.request(.tariffs, returning: TariffsResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func meditationDetail(id: Int, completion: @escaping(_ error:String?,_ module: MeditationDetailResponse?)->()) {
        router.request(.meditationDetail(id: id), returning: MeditationDetailResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func affirmationDetail(id: Int, completion: @escaping(_ error:String?,_ module: AffirmationDetailResponse?)->()) {
        router.request(.affiramtionDetail(id: id), returning: AffirmationDetailResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func payment(receipt: String, tariffId: Int, completion: @escaping(_ error: String?,_ module: PaymentResponse?)->()) {
        router.request(.payment(receipt: receipt, tariffId: tariffId), returning: PaymentResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func countries(completion: @escaping(_ error: String?,_ module: CountriesResponse?)->()) {
        router.request(.countries, returning: CountriesResponse.self) { error, response in
            completion(error, response)
        }
    }
    
    func currentListeners(completion: @escaping(_ error: String?,_ module: CurrentListenersResponse?)->()) {
        router.request(.currentListeners, returning: CurrentListenersResponse.self) { error, response in
            completion(error, response)
        }
    }
}
