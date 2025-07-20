//
//  Lesson.swift
//  UniFlow
//
//  Created by Алия Гумирова on 02.07.2025.
//

import Foundation

struct Lesson: Identifiable {
    let id: UUID
    let title: String
    let teacher: String
    let type: String
    let format: String
    let status: Bool
    let time: String
    let room: String?
    
    init(event: Event) {
        self.id = event.id!
        self.title = event.descriptions ?? "Отсутствует название"
        self.teacher = event.instructor_name ?? "Отсутствует преподаватель"
        self.type = event.session_type ?? "Отсутствует тип"
        self.format = event.delivery_mode ?? "Отсутствует формат"
        self.status = event.is_cancelled
        self.time = event.time_range ?? "Отсутствует время"
        self.room = event.classroom
    }
}
