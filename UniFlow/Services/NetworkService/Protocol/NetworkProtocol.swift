//
//  NetworkProtocol.swift
//  UniFlow
//
//  Created by Алексей on 17.07.2025.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
    func getData<T: Decodable>(of type: T.Type, endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void)
}
