//
//  Date+Utils.swift
//  UniFlow
//
//  Created by Алия Гумирова on 02.07.2025.
//

import Foundation

extension Date {
    func stripTime() -> Date {
        Calendar.current.startOfDay(for: self)
    }

    func adding(days: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: self)!
    }

    func weekDates() -> [Date] {
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: self)?.start ?? self
        return (0..<7).map { startOfWeek.addingTimeInterval(Double($0) * 86400) }
    }

    func formattedDayLabel() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }

    func weekdayShortName() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "E"
        return formatter.string(from: self)
    }
}
