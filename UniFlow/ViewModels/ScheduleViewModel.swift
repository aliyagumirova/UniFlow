//
//  ScheduleViewModel.swift
//  UniFlow
//
//  Created by Алия Гумирова on 02.07.2025.
//

import Foundation

final class ScheduleViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var lessons: [Date: [Lesson]] = [:]

    init() {
        generateMockData()
    }

    var lessonsForSelectedDate: [Lesson] {
        lessons[selectedDate.stripTime()] ?? []
    }

    private func generateMockData() {
        let today = Date().stripTime()
        lessons[today] = [
            Lesson(title: "Иностранный язык в профессиональной деятельности",
                   teacher: "Константинопольский К.К.",
                   type: .lecture,
                   format: .offline,
                   status: .active,
                   time: "10:45 — 12:20",
                   room: "209 ауд."),
            
            Lesson(title: "Иностранный язык в профессиональной деятельности",
                   teacher: "Константинопольский К.К.",
                   type: .lecture,
                   format: .offline,
                   status: .cancelled,
                   time: "12:45 — 13:20",
                   room: nil),
            
            Lesson(title: "Иностранный язык в профессиональной деятельности",
                   teacher: "Константинопольский К.К.",
                   type: .lecture,
                   format: .online,
                   status: .active,
                   time: "13:45 — 14:20",
                   room: nil),
            
            Lesson(title: "Иностранный язык в профессиональной деятельности",
                   teacher: "Константинопольский К.К.",
                   type: .lecture,
                   format: .offline,
                   status: .replacement,
                   time: "14:45 — 15:20",
                   room: "209 ауд."),
            
            Lesson(title: "Иностранный язык в профессиональной деятельности",
                   teacher: "Константинопольский К.К.",
                   type: .lecture,
                   format: .offline,
                   status: .replacement,
                   time: "15:45 — 16®:20",
                   room: "209 ауд.")
        ]
    }
}
