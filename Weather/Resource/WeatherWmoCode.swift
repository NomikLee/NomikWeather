//
//  WeatherWmoCode.swift
//  Weather
//
//  Created by Pinocchio on 2024/10/20.
//

import Foundation
import UIKit

enum WeatherWmo {
    case clearSky
    case mainlyClear
    case partlyCloudy
    case Overcast
    case fog
    case depositingRimeFog
    case drizzleLight
    case drizzleModerate
    case drizzleDenseIntensity
    case freezingDrizzleLight
    case freezingDrizzleDenseIntensity
    case rainSlight
    case rainModerate
    case rainHeavyIntensity
    case freezingRainLight
    case freezingRainHeavyIntensity
    case snowFallSlight
    case snowFallModerate
    case snowFallHeavyIntensity
    case snowGrains
    case rainShowersSlight
    case rainShowersModerate
    case rainShowersViolent
    case snowShowersSlight
    case snowShowersHeavy
    case thunderstormSlight
    case thunderstormModerate
    case thunderstormWithSlight
    case thunderstormWithHeavyHail
    case noSingle
    
    var weatherIconImage: UIImage? {
        switch self {
        case .clearSky:
            return UIImage(systemName: "sun.max.fill")
        case .mainlyClear:
            return UIImage(systemName: "cloud.sun.fill")
        case .partlyCloudy:
            return UIImage(systemName: "cloud.fill")
        case .Overcast:
            return UIImage(systemName: "smoke.fill")
        case .fog:
            return UIImage(systemName: "cloud.fog.fill")
        case .depositingRimeFog:
            return UIImage(systemName: "cloud.fog.fill")
        case .drizzleLight:
            return UIImage(systemName: "cloud.drizzle.fill")
        case .drizzleModerate:
            return UIImage(systemName: "cloud.drizzle.fill")
        case .drizzleDenseIntensity:
            return UIImage(systemName: "cloud.drizzle.fill")
        case .freezingDrizzleLight:
            return UIImage(systemName: "cloud.drizzle.fill")
        case .freezingDrizzleDenseIntensity:
            return UIImage(systemName: "cloud.drizzle.fill")
        case .rainSlight:
            return UIImage(systemName: "cloud.rain.fill")
        case .rainModerate:
            return UIImage(systemName: "cloud.rain.fill")
        case .rainHeavyIntensity:
            return UIImage(systemName: "cloud.heavyrain.fill")
        case .freezingRainLight:
            return UIImage(systemName: "cloud.sleet.fill")
        case .freezingRainHeavyIntensity:
            return UIImage(systemName: "cloud.sleet.fill")
        case .snowFallSlight:
            return UIImage(systemName: "cloud.snow.fill")
        case .snowFallModerate:
            return UIImage(systemName: "cloud.snow.fill")
        case .snowFallHeavyIntensity:
            return UIImage(systemName: "cloud.snow.fill")
        case .snowGrains:
            return UIImage(systemName: "snowflake")
        case .rainShowersSlight:
            return UIImage(systemName: "cloud.sun.rain.fill")
        case .rainShowersModerate:
            return UIImage(systemName: "cloud.sun.rain.fill")
        case .rainShowersViolent:
            return UIImage(systemName: "cloud.sun.rain.fill")
        case .snowShowersSlight:
            return UIImage(systemName: "sun.snow.fill")
        case .snowShowersHeavy:
            return UIImage(systemName: "sun.snow.fill")
        case .thunderstormSlight:
            return UIImage(systemName: "cloud.bolt.fill")
        case .thunderstormModerate:
            return UIImage(systemName: "cloud.bolt.fill")
        case .thunderstormWithSlight:
            return UIImage(systemName: "cloud.bolt.rain.fill")
        case .thunderstormWithHeavyHail:
            return UIImage(systemName: "cloud.bolt.rain.fill")
        case .noSingle:
            return UIImage(systemName: "xmark.icloud.fill")
        }
    }
    
    var weatherCodeWMO: Int {
        switch self {
        case .clearSky:
            return 0
        case .mainlyClear:
            return 1
        case .partlyCloudy:
            return 2
        case .Overcast:
            return 3
        case .fog:
            return 45
        case .depositingRimeFog:
            return 48
        case .drizzleLight:
            return 51
        case .drizzleModerate:
            return 53
        case .drizzleDenseIntensity:
            return 55
        case .freezingDrizzleLight:
            return 56
        case .freezingDrizzleDenseIntensity:
            return 57
        case .rainSlight:
            return 61
        case .rainModerate:
            return 63
        case .rainHeavyIntensity:
            return 65
        case .freezingRainLight:
            return 66
        case .freezingRainHeavyIntensity:
            return 67
        case .snowFallSlight:
            return 71
        case .snowFallModerate:
            return 73
        case .snowFallHeavyIntensity:
            return 75
        case .snowGrains:
            return 77
        case .rainShowersSlight:
            return 80
        case .rainShowersModerate:
            return 81
        case .rainShowersViolent:
            return 82
        case .snowShowersSlight:
            return 85
        case .snowShowersHeavy:
            return 86
        case .thunderstormSlight:
            return 95
        case .thunderstormModerate:
            return 95
        case .thunderstormWithSlight:
            return 96
        case .thunderstormWithHeavyHail:
            return 99
        case .noSingle:
            return 100
        }
    }
    
    var weatherChinese: String {
        switch self {
        case .clearSky:
            return "晴天"
        case .mainlyClear:
            return "晴時多雲"
        case .partlyCloudy:
            return "多雲"
        case .Overcast:
            return "多雲時陰"
        case .fog:
            return "起霧"
        case .depositingRimeFog:
            return "霜霧"
        case .drizzleLight:
            return "小毛毛雨"
        case .drizzleModerate:
            return "有感毛毛雨"
        case .drizzleDenseIntensity:
            return "厚實毛毛雨"
        case .freezingDrizzleLight:
            return "凍毛毛雨"
        case .freezingDrizzleDenseIntensity:
            return "厚實凍毛毛雨"
        case .rainSlight:
            return "下小雨"
        case .rainModerate:
            return "下雨"
        case .rainHeavyIntensity:
            return "下大雨"
        case .freezingRainLight:
            return "小凍雨"
        case .freezingRainHeavyIntensity:
            return "厚實凍雨"
        case .snowFallSlight:
            return "下小雪"
        case .snowFallModerate:
            return "下中雪"
        case .snowFallHeavyIntensity:
            return "下大雪"
        case .snowGrains:
            return "雪粒"
        case .rainShowersSlight:
            return "小陣雨"
        case .rainShowersModerate:
            return "中陣雨"
        case .rainShowersViolent:
            return "大陣雨"
        case .snowShowersSlight:
            return "小陣雪"
        case .snowShowersHeavy:
            return "大陣雪"
        case .thunderstormSlight:
            return "輕微雷暴雨"
        case .thunderstormModerate:
            return "中型雷暴雨"
        case .thunderstormWithSlight:
            return "下小冰雹"
        case .thunderstormWithHeavyHail:
            return "下大冰雹"
        case .noSingle:
            return "--"
        }
    }
}
