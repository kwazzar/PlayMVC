//
//  NetworkManager.swift
//  PlayMVC
//
//  Created by Quasar on 27.04.2024.
//
import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func loadData<T: Codable>(endpoint: String, decodeType: T.Type, completion: @escaping (T?) -> Void) {
        AF.request(endpoint, method: .get).responseDecodable(of: T.self) { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                // Сохраняем данные в кеше
                CacheManager.shared.cacheData(value, for: endpoint)
                completion(value)
            case .failure(let error):
                print(error)
                // Если есть ошибка сети, пытаемся загрузить данные из кеша
                if let cachedData: T = CacheManager.shared.getCachedData(for: endpoint, decodeType: T.self) {
                    completion(cachedData)
                } else {
                    completion(nil)
                }
            }
        }
    }
}
