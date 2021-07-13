//
//  Enum.swift
//  Samokat
//
//  Created by Daniyar on 7/7/20.
//  Copyright © 2020 MTI. All rights reserved.
//

import Foundation
import UIKit

enum FontStyles: String {
    case mediumItalic = "MediumItalic"
    case medium = "Medium"
    case lightItalic = "LightItalic"
    case light = "Light"
    case bookItalic = "BookItalic"
    case book = "Book"
    case ultraItalic = "UltraItalic"
    case ultra = "Ultra"
    case boldItalic = "BoldItalic"
    case bold = "Bold"
    case extraLightItalic = "ExtraLightItalic"
    case extraLight = "ExtraLight"
}

enum MontserratStyles: String {
    case regular = "Montserrat-Regular"
    case italic = "Montserrat-Italic"
    case thin = "Montserrat-Thin"
    case thinItalic = "Montserrat-ThinItalic"
    case extraLight = "Montserrat-ExtraLight"
    case extraLightItalic = "Montserrat-ExtraLightItalic"
    case light = "Montserrat-Light"
    case lightItalic = "Montserrat-LightItalic"
    case medium = "Montserrat-Medium"
    case mediumItalic = "Montserrat-MediumItalic"
    case semiBold = "Montserrat-SemiBold"
    case semiBoldItalic = "Montserrat-SemiBoldItalic"
    case bold = "Montserrat-Bold"
    case boldItalic = "Montserrat-BoldItalic"
    case extraBold = "Montserrat-ExtraBold"
    case extraBoldItalic = "Montserrat-ExtraBoldItalic"
    case black = "Montserrat-Black"
    case blackItalic = "Montserrat-BlackItalic"
}

enum JuraStyles: String {
    case light = "Jura-Light"
}

enum Language: String, CaseIterable {
    case kz = "kz"
    case ru = "ru"
    
    var number: Int {
        switch self {
        case .ru:
            return 1
        case .kz:
            return 2
        }
    }
    
    var name: String {
        switch self {
        case .ru:
            return "Русский язык"
        case .kz:
            return "Казахский язык"
        }
    }
    
    var interestName: String {
        switch self {
        case .ru:
            return "COMMON_RU"
        case .kz:
            return "COMMON_KZ"
        }
    }
}

enum AuthType: String {
    case email
    case gmail
    case facebook
    case vk
    case apple
    
    var buttonTitle: String {
        switch self {
        case .email:
            return "Войти с помощью E-mail".localized
        case .gmail:
            return "Войти через Google".localized
        case .facebook:
            return "Войти через Facebook".localized
        case .vk:
            return "Войти через VK".localized
        case .apple:
            return "Войти с Apple".localized
        }
    }
    
    var image: UIImage? {
        switch self {
        case .email:
            return nil
        case .gmail:
            return UIImage(named: "google")
        case .facebook:
            return UIImage(named: "fb")
        case .vk:
            return UIImage(named: "vk")
        case .apple:
            return UIImage(named: "apple")
        }
    }
    
    var apiName: String? {
        switch self {
        case .email:
            return nil
        case .gmail:
            return "google"
        case .facebook:
            return "facebook"
        case .vk:
            return "vk"
        case .apple:
            return "apple"
        }
    }
}

enum AuthViewType {
    case login
    case register
    case restoreEmail
    case restorePassword
    
    var fieldTypes: [AuthFieldType] {
        switch self {
        case .login:
            return [.loginEmail, .loginPassword]
        case .register:
            return [.registerEmail, .registerPassword, .registerRepeatPassword]
        case .restoreEmail:
            return [.restoreEmail]
        case .restorePassword:
            return [.restorePassword, .restoreRepeatPassword]
        }
    }
    
    var titleOnTop: Bool {
        return [.restoreEmail, .restorePassword].contains(self)
    }
    
    var title: String {
        switch self {
        case .login:
            return "Войти".localized
        case .register:
            return "Регистрация".localized
        case .restoreEmail:
            return "Восстановление пароля".localized
        case .restorePassword:
            return "Восстановление пароля".localized
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .login:
            return "Войти".localized
        case .register, .restoreEmail:
            return "Далее".localized
        case .restorePassword:
            return "Сохранить".localized
        }
    }
}

enum AuthFieldType {
    case loginEmail
    case loginPassword
    case registerEmail
    case registerPassword
    case registerRepeatPassword
    case restoreEmail
    case restorePassword
    case restoreRepeatPassword
    
    var title: String {
        switch self {
        case .loginEmail, .registerEmail:
            return "Электронная почта".localized
        case .loginPassword, .registerPassword:
            return "Пароль".localized
        case .registerRepeatPassword:
            return "Повторите пароль".localized
        case .restoreEmail:
            return "Введите адрес электронной почты, и мы отправим Вам ссылку для восстановления доступа к аккаунту".localized
        case .restorePassword:
            return "Введите новый пароль".localized
        case .restoreRepeatPassword:
            return "Повторите новый пароль".localized
        }
    }
    
    var placeholder: String {
        switch self {
        case .loginEmail, .registerEmail:
            return "Введите свой E-mail".localized
        case .loginPassword, .registerPassword:
            return "Введите свой пароль".localized
        case .registerRepeatPassword:
            return "Повторите свой пароль".localized
        case .restoreEmail:
            return "Введите E-mail".localized
        case .restorePassword:
            return "Введите пароль".localized
        case .restoreRepeatPassword:
            return "Повторите пароль".localized
        }
    }
}

enum CollectionType {
    case medium
    case wide
    case tall
    case challenge
    case currentListeners
    case affirmations
    
    var height: CGFloat {
        switch self {
        case .medium, .wide:
            return StaticSize.size(272)
        case .challenge:
            return StaticSize.size(320)
        case .tall, .affirmations:
            return StaticSize.size(344)
        case .currentListeners:
            return StaticSize.size(62)
        }
    }
    
    var placeholderImage: UIImage {
        switch self {
        case .medium, .challenge:
            return UIImage(named: "imagePlaceholderMedium")!
        case .wide:
            return UIImage(named: "imagePlaceholderWide")!
        case .tall, .affirmations:
            return UIImage(named: "imagePlaceholderTall")!
        default:
            return UIImage()
        }
    }
}

enum MainItemsType: Int {
    case recommendation = 1
    case collections = 2
    case favorites = 3
    case challenges = 4
    case courses = 5
}

enum CreateItemsType: Int {
    case collection = 1
    case affirmations = 2
}

enum CellContentStyle {
    case lightContent
    case darkContent
}

enum MeditationViewType {
    case list
    case detail
}

enum MeditationButtonType {
    case backgroundMusic
    case dictorVoice
    
    var title: String {
        switch self {
        case .backgroundMusic:
            return "Фоновая музыка".localized
        case .dictorVoice:
            return "Голос диктора".localized
        }
    }
    
    var image: UIImage? {
        switch self {
        case .backgroundMusic:
            return UIImage(named: "landscape")
        case .dictorVoice:
            return UIImage(named: "microphone")
        }
    }
}

enum VoiceTypes {
    case male
    case female
    
    var title: String {
        switch self {
        case .male:
            return "Мужской".localized
        case .female:
            return "Женский".localized
        }
    }
}

enum BackgroundMusic: String, CaseIterable {
    case wayToHarmony = "Путь к гармонии"
    case forrestMagic = "Магия леса"
    case fullCup = "Наполненная чаша"
    case cleanSound = "Чистое звучание"
    case unionBeing = "Единство бытия"
    case rainWind = "Дождь и песнь ветра"
    case spaceSpirit = "Космический дух"
    case trueKnowledge = "Истинное познание"
    case birdsRiver = "Ласточки над рекой"
    case summerRain = "Летний дождь"
    case fireCreature = "Огонь Творения"
    case fullUnderstand = "Полное осознание"
    
    var name: String {
        return self.rawValue.localized
    }
    
    var url: URL {
        switch self {
        case .wayToHarmony:
            return Bundle.main.url(forResource: "путь к гармонии", withExtension: "mp3")!
        case .forrestMagic:
            return Bundle.main.url(forResource: "магия леса", withExtension: "mp3")!
        case .fullCup:
            return Bundle.main.url(forResource: "наполненная чаша", withExtension: "mp3")!
        case .cleanSound:
            return Bundle.main.url(forResource: "чистое звучание", withExtension: "mp3")!
        case .unionBeing:
            return Bundle.main.url(forResource: "единство бытия", withExtension: "mp3")!
        case .rainWind:
            return Bundle.main.url(forResource: "дождь и песнь ветра", withExtension: "mp3")!
        case .spaceSpirit:
            return Bundle.main.url(forResource: "космический дух", withExtension: "mp3")!
        case .trueKnowledge:
            return Bundle.main.url(forResource: "истинное познание", withExtension: "mp3")!
        case .birdsRiver:
            return Bundle.main.url(forResource: "ласточки над рекой", withExtension: "mp3")!
        case .summerRain:
            return Bundle.main.url(forResource: "летний дождь", withExtension: "mp3")!
        case .fireCreature:
            return Bundle.main.url(forResource: "Огонь Творения", withExtension: "mp3")!
        case .fullUnderstand:
            return Bundle.main.url(forResource: "полное осознание", withExtension: "mp3")!
        }
    }
}

enum FavoriteMeditationAction {
    case add
    case delete
}

enum ProfileInfoCellType {
    case faq
    case help
    case language
    case promocode
    
    var title: String {
        switch self {
        case .faq:
            return "FAQ".localized
        case .help:
            return "Помощь".localized
        case .language:
            return "Сменить язык".localized
        case .promocode:
            return "Ввести промо-код".localized
        }
    }
}

enum Case {
    case nominitive
    case genetive
}

enum TimeType {
    case days
    case minutes
}

enum LevelViewType {
    case profile
    case list
}

enum Month: Int {
    case jan = 1
    case feb = 2
    case mar = 3
    case apr = 4
    case may = 5
    case jun = 6
    case jul = 7
    case aug = 8
    case sep = 9
    case oct = 10
    case nov = 11
    case dec = 12
    
    var name: String {
        switch self {
        case .jan:
            return "Январь".localized
        case .feb:
            return "Февраль".localized
        case .mar:
            return "Март".localized
        case .apr:
            return "Апрель".localized
        case .may:
            return "Май".localized
        case .jun:
            return "Июнь".localized
        case .jul:
            return "Июль".localized
        case .aug:
            return "Август".localized
        case .sep:
            return "Сентябрь".localized
        case .oct:
            return "Октябрь".localized
        case .nov:
            return "Ноябрь".localized
        case .dec:
            return "Декабрь".localized
        }
    }
}

enum Weekday: RawRepresentable, CaseIterable {
    typealias RawValue = Int?
    
    case everyDay
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    case sun
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case 1: self = .mon
        case 2: self = .tue
        case 3: self = .wed
        case 4: self = .thu
        case 5: self = .fri
        case 6: self = .sat
        case 0: self = .sun
        default: return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
            case .everyDay: return nil
            case .mon: return 1
            case .tue: return 2
            case .wed: return 3
            case .thu: return 4
            case .fri: return 5
            case .sat: return 6
            case .sun: return 0
        }
    }
    
    var name: String {
        switch self {
        case .everyDay: return "Каждый день".localized
        case .mon: return "Понедельник".localized
        case .tue: return "Вторник".localized
        case .wed: return "Среда".localized
        case .thu: return "Четверг".localized
        case .fri: return "Пятница".localized
        case .sat: return "Суббота".localized
        case .sun: return "Воскресенье".localized
        }
    }
}

enum NotificationType: String {
    case meditation
    case collection
    case affirmation
    case challenge
    case pushLink = "push_link"
    case test
}
