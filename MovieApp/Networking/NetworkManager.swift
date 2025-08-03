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
    func fetchData<T: Decodable>(url: URL, completion: @escaping (Result<T, AFError>) -> Void) {
        
        let header: HTTPHeaders = [
            "Authorization": MovieAPI.apiKey,
        ]
        
        AF.request(url, headers: header)
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
    
    func makeURL(path: MovieAPI.Path.RawValue) -> URL? {
        var components = URLComponents()
        components.scheme = MovieAPI.scheme
        components.host = MovieAPI.host
        components.path = path
        components.queryItems = MovieAPI.queryItems
        return components.url
    }
}
