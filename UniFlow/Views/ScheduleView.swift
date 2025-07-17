//
//  ScheduleView.swift
//  UniFlow
//
//  Created by Алия Гумирова on 02.07.2025.
//

import SwiftUI

struct ScheduleView: View {
    @StateObject private var viewModel = ScheduleViewModel()

    var body: some View {
        VStack(spacing: 12) {
            // 🖤 Заголовок "Расписание" с колокольчиком
            HStack {
                Text("Расписание")
                    .font(.system(size: 36))
                    .foregroundColor(Color("textPrimary")) // #383838

                Spacer()

                Button(action: {
                    print("Уведомления")
                }) {
                    Image(systemName: "bell")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.black)
                        .frame(width: 48, height: 48)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                    
//                    Image(systemName: "bell")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 24, height: 24)
//                        .foregroundColor(Color("Violet"))
                }
            }
            .padding(.horizontal)
            .padding(.top, 16)
            .padding(.bottom, 20)

            // 🟣 Верхняя панель: месяц + неделя + календарик
            HStack {
                Text(monthWeekText)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(Color("fontColor"))
                    .frame(width: 197, height: 48)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.black.opacity(0.8), lineWidth: 1)
                    )
                    .cornerRadius(24)

                Spacer()

                Button(action: {
                    print("Календарь на будущее")
                }) {
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                        .foregroundColor(.white)
                        .frame(width: 48, height: 48)
                        .background(Color("Violet"))
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                }
            }
            .padding(.horizontal)

            // 🔄 Линия дней с переключателями недели
            HStack {
                Button(action: {
                    viewModel.selectedDate = viewModel.selectedDate.addingTimeInterval(-7 * 86400)
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .frame(width: 16, height: 16)
                }

                Spacer()

                WeekdaySelectorView(selectedDate: $viewModel.selectedDate)
                    .frame(width: 308, height: 72)

                Spacer()

                Button(action: {
                    viewModel.selectedDate = viewModel.selectedDate.addingTimeInterval(7 * 86400)
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                        .frame(width: 16, height: 16)
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 72)

            // 📋 Список занятий
            ScrollView {
                VStack(spacing: 0) {
                    if viewModel.lessonsForSelectedDate.isEmpty {
                        Text("Нет занятий на этот день")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                            .padding(.top, 32)
                    } else {
                        VStack(spacing: 16) {
                            ForEach(viewModel.lessonsForSelectedDate) { lesson in
                                LessonCardView(lesson: lesson)
                            }
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                        .background(Color.white)
                        .cornerRadius(24)
                    }
                }
            }

            Spacer(minLength: 0)
        }
        .background(Color.bgLight.ignoresSafeArea())
    }

    private var monthWeekText: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "LLLL"
        let month = formatter.string(from: viewModel.selectedDate)
        let week = Calendar.current.component(.weekOfYear, from: viewModel.selectedDate)
        return "\(month.capitalized), \(week) нед."
    }
}

#Preview {
    ScheduleView()
}
