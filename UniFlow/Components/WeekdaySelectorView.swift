//
//  WeekdaySelectorView.swift
//  UniFlow
//
//  Created by Алия Гумирова on 02.07.2025.
//

import SwiftUI

struct WeekdaySelectorView: View {
    @Binding var selectedDate: Date

    private var weekDates: [Date] {
        guard let startOfWeek = Calendar.current.dateInterval(of: .weekOfYear, for: selectedDate)?.start else {
            return []
        }
        return (0..<7).compactMap { Calendar.current.date(byAdding: .day, value: $0, to: startOfWeek) }
    }

    var body: some View {
        HStack(spacing: 4) { // было 8
            ForEach(weekDates, id: \.self) { date in
                Button(action: {
                    selectedDate = date
                }) {
                    WeekdayView(date: date, isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate))
                }
            }
        }
    }
}

private struct WeekdayView: View {
    let date: Date
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 4) {
            Text(weekdayAbbreviation)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(isSelected ? .white : Color("textSecondary"))

            Text(dayNumber)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(isSelected ? .white : Color("textPrimary"))
        }
        .frame(width: 44, height: 68)
        .background(isSelected ? Color("Violet") : Color.clear)
        .cornerRadius(isSelected ? 40 : 16)
    }

    private var weekdayAbbreviation: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "EE" // Вс, Пн и т.д.
        return formatter.string(from: date)
    }

    private var dayNumber: String {
        let day = Calendar.current.component(.day, from: date)
        return "\(day)"
    }
}

