//
//  Keys.swift
//  PlayMVC
//
//  Created by Quasar on 03.05.2024.
//
import Foundation

enum KeysUrl {
    case endpoint
    case appStoreURL
    case contactUsURL
    
    var key : String {
        let key: String
        switch self {
        case .endpoint:
            key = "http://ip-api.com/json/?fields=66846719"
        case .appStoreURL:
            key = "https://www.apple.com/app-store/"
        case .contactUsURL:
            key = "https://energise.notion.site/Swift-fac45cd4d51640928ce8e7ea38552fc3"
        }
        return key
    }
}
