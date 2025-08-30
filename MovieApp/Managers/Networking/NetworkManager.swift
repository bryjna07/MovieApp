//
//  NetworkManager.swift
//  MovieApp
//
//  Created by YoungJin on 8/3/25.
//

import Foundation
import Alamofire

//MARK: - Networking
final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    /// API 요청 메서드
    func fetchData<T: Decodable>(_ router: Router, completion: @escaping (Result<T, AFError>) -> Void) {
        
        AF.request(router)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
