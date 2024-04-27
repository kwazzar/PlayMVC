//
//  NetworkManager.swift
//  PlayMVC
//
//  Created by Quasar on 27.04.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()

    private init() {}

    func loadData<T: Codable>(endpoint: String, decodeType: T.Type, completion: @escaping (T?) -> Void) {
        AF.request(endpoint, method: .get).responseDecodable(of: T.self) { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                print(error)
                completion(nil)
            }
        }
    }

}