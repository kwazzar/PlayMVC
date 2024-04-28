//
//  Model.swift
//  PlayMVC
//
//  Created by Quasar on 26.04.2024.
//

//MARK: FIRST View
enum ButtonState {
    case play
    case pause

}

//MARK: Second View
struct IPAddressInfo: Codable {
    let `as`: String
    let org: String
    let country: String
    let query: String
    let timezone: String
    let zip: String
    let isp: String
    let city: String
    let lon: Double
    let regionName: String
    let status: String
    let region: String
    let lat: Double
    let countryCode: String

    enum CodingKeys: String, CodingKey {
        case `as` = "as"
        case org = "org"
        case country = "country"
        case query = "query"
        case timezone = "timezone"
        case zip = "zip"
        case isp = "isp"
        case city = "city"
        case lon = "lon"
        case regionName = "regionName"
        case status = "status"
        case region = "region"
        case lat = "lat"
        case countryCode = "countryCode"
    }
}


