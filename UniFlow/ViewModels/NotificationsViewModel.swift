//
//  NotificationsViewModel.swift
//  UniFlow
//
//  Created by Алия Гумирова on 17.07.2025.
//


import Foundation
import SwiftUI

final class NotificationsViewModel: ObservableObject {
    @Published var notifications: [NotificationItem] = [
        NotificationItem(
            title: "Занятие отменено",
            time: "18:40",
            isNew: true,
            type: .regular(message: "Занятие по «Математические методы» 26.09 в 10.45 отменено. Следите за обновлениями в расписании.")
        ),
        NotificationItem(
            title: "Математические методы",
            time: "18:40",
            isNew: true,
            type: .lectureReview(isRated: false, message: "Как прошла лекция? Поставьте оценку – это займет меньше минуты.")
        ),
        NotificationItem(
            title: "Философия",
            time: "18:40",
            isNew: false,
            type: .lectureReview(isRated: true, message: "Спасибо. Ваша оценка успешно сохранена"),
            rating: 2
        )
    ]


    @Published var selectedNotification: NotificationItem? = nil

    //Все уведомления (вне зависимости от isNew)
    var allNotifications: [NotificationItem] {
        notifications
    }

    //Все lectureReview-уведомления (в том числе уже оценённые)
    var lectureReviewNotifications: [NotificationItem] {
        notifications.filter {
            if case .lectureReview = $0.type {
                return true
            }
            return false
        }
    }

    //Отмечаем уведомление как оценённое
    func markNotification(_ notification: NotificationItem, withRating rating: Int) {
        if let index = notifications.firstIndex(where: { $0.id == notification.id }) {
            notifications[index].type = .lectureReview(
                isRated: true,
                message: "Спасибо. Ваша оценка успешно сохранена"
            )
            notifications[index].rating = rating
            notifications[index].isNew = false
        }
    }

}
