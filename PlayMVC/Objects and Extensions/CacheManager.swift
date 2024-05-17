//
//  CacheManager.swift
//  PlayMVC
//
//  Created by Quasar on 28.04.2024.
//
import Foundation

final class CacheManager {
    static let shared = CacheManager()
    private let fileManager = FileManager.default
    private lazy var cacheDirectoryURL: URL = {
        if let url = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Unable to access the cache directory.")
        }
    }()
    
    func cacheData<T: Codable>(_ object: T, for endpoint: String) {
        let validFilename = endpoint.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? endpoint
        let fileURL = cacheDirectoryURL.appendingPathComponent(validFilename)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(object)
            try data.write(to: fileURL)
        } catch {
            print("Error caching data: \(error)")
        }
    }
    
    func getCachedData<T: Codable>(for endpoint: String, decodeType: T.Type) -> T? {
        let validFilename = endpoint.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? endpoint
        let fileURL = cacheDirectoryURL.appendingPathComponent(validFilename)
        if fileManager.fileExists(atPath: fileURL.path), let data = try? Data(contentsOf: fileURL) {
            let decoder = JSONDecoder()
            let decodedObject = try? decoder.decode(T.self, from: data)
            return decodedObject
        }
        return nil
    }
}
