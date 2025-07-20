//
//  NetworkError.swift
//  UniFlow
//
//  Created by Алексей on 17.07.2025.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case serverError(Int)
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Неверный URL"
        case .serverError(let code):
            return "Сервер вернул ошибку с кодом: \(code)"
        case .unknown:
            return "Неизвестная ошибка"
        }
    }
}
