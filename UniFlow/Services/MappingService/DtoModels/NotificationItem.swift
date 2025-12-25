//
//  NotificationItem.swift
//  UniFlow
//
//  Created by Алия Гумирова on 17.07.2025.
//

import Foundation
import SwiftUI

enum NotificationType: Equatable {
    case regular(message: String)
    case lectureReview(isRated: Bool, message: String)

    var message: String {
        switch self {
        case .regular(let message):
            return message
        case .lectureReview(_, let message):
            return message
        }
    }
}


struct NotificationItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let time: String
    var isNew: Bool
    var type: NotificationType
    var rating: Int? = nil

    var message: String {
        type.message
    }
}




