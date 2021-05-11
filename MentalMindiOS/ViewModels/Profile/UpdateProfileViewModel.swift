//
//  UpdateProfileViewModel.swift
//  MentalMindiOS
//
//  Created by Daniyar on 17.12.2020.
//

import Foundation
import RxSwift

class UpdateProfileViewModel {
    lazy var user = PublishSubject<User>()
    lazy var countries = PublishSubject<[Country]>()
    
    var updateResponse: MeResponse? {
        didSet {
            guard let user = updateResponse?.data else { return }
            AppShared.sharedInstance.user = user
            self.user.onNext(user)
        }
    }
    
    var countriesResponse: CountriesResponse? {
        didSet {
            guard let countries = countriesResponse?.data?.results else { return }
            self.countries.onNext(countries)
        }
    }
    
    func updateProfile(profileImage: URL? = nil, fullName: String? = nil, birthday: String? = nil, language: Language? = nil, country: String? = nil, city: String? = nil) {
        APIManager.shared.updateProfile(profileImage: profileImage, fullName: fullName, birthday: birthday, language: language, country: country, city: city) { error, response in
            self.updateResponse = response
        }
    }
    
    func getCountries() {
        APIManager.shared.countries() { error, response in
            self.countriesResponse = response
        }
    }
}
