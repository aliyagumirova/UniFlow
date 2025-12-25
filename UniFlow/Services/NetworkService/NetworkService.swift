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
                    let statusCode = response.response?.statusCode ?? -1
                       let networkError: NetworkError
                       switch statusCode {
                       case 400...499:
                           networkError = .clientError(statusCode)
                       case 500...599:
                           networkError = .serverError(statusCode)
                       default:
                           networkError = .unknown
                       }

                       if let data = response.data,
                          let body = String(data: data, encoding: .utf8) {
                           print("Body: \(body)")
                       }

                       if let afErr = error.asAFError {
                           switch afErr {
                           case .responseSerializationFailed(let reason):
                               print("Decoding error: \(reason)")
                           default:
                               break
                           }
                       }

                       print("Detailed error: \(networkError) — \(error.localizedDescription)")
                       DispatchQueue.main.async {
                           completion(.failure(networkError))
                       }
                }
            }
    }
    
    func getData<T: Decodable>(of type: T.Type, endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        request(of: type, endpoint: endpoint, completion: completion)
    }
}
