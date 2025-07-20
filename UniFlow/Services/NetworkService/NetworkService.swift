//
//  NetworkService.swift
//  UniFlow
//
//  Created by Алексей on 17.07.2025.
//

import Foundation
import Alamofire

final class NetworkService: NetworkProtocol {
    private func request<T: Decodable>(of type: T.Type, endpoint: APIEndpoint, method: HTTPMethod = .get, completion: @escaping (Result<T,Error>) -> Void) {
        
        guard let url = endpoint.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        AF.request(url, method: method)
            .validate()
            .responseDecodable(of: type, queue: .global(qos: .background)) { response in
                switch response.result {
                case .success(let value):
                    DispatchQueue.main.async {
                        completion(.success(value))
                    }
                case .failure(let error):
                    let networkError: NetworkError
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case 400...500:
                            networkError = .serverError(statusCode)
                        case 500...599:
                            networkError = .serverError(statusCode)
                        default:
                            networkError = .unknown
                        }
                    } else {
                        networkError = .unknown
                    }
                    completion(.failure(networkError))
                    print(error.localizedDescription)
                }
            }
    }
    
    func getData<T: Decodable>(of type: T.Type, endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        request(of: type, endpoint: endpoint, completion: completion)
    }
}
