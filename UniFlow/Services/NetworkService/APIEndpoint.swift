//
//  APIEndpoint.swift
//  UniFlow
//
//  Created by Алексей on 17.07.2025.
//

import Foundation
import Alamofire

enum APIEndpoint {
    private static let baseURLString = "https://events.reg.skroy.ru/api/"
    
    case getEvents
    
    var url: URL? {
        switch self {
        case .getEvents:
            return URL(string: "\(APIEndpoint.baseURLString)events/")
        }
    }
}
