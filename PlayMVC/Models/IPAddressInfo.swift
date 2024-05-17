//
//  IPAddressInfo.swift
//  PlayMVC
//
//  Created by Quasar on 26.04.2024.
//
import CoreLocation

struct IPAddressInfo: Codable {
    let `as`: String
    let org: String
    let country: String
    let query: String
    let timezone: String
    let zip: String
    let isp: String
    let city: String
    let regionName: String
    let status: String
    let region: String
    let countryCode: String
    let lat: Double
    let lon: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    var infoDictionary: [String: String] {
        return [
            "IP": query,
            "ISP": isp,
            "Organization": org,
            "Country": "\(country) (\(countryCode))",
            "Region": "\(regionName) (\(region))",
            "City": city,
            "Zip Code": zip,
            "Timezone": timezone,
            "Latitude": "\(lat)",
            "Longitude": "\(lon)"
        ]
    }
}


