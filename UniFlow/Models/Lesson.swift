//
//  Lesson.swift
//  UniFlow
//
//  Created by Алия Гумирова on 02.07.2025.
//

import Foundation

enum LessonStatus {
    case active, cancelled, replacement
}

enum LessonFormat {
    case online, offline
}

enum LessonType {
    case lecture, seminar
}

struct Lesson: Identifiable {
    let id = UUID()
    let title: String
    let teacher: String
    let type: LessonType
    let format: LessonFormat
    let status: LessonStatus
    let time: String
    let room: String?
}
