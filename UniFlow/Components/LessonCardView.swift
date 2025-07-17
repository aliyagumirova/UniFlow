//
//  LessonCardView.swift
//  UniFlow
//
//  Created by Алия Гумирова on 02.07.2025.
//
import SwiftUI

struct LessonCardView: View {
    let lesson: Lesson

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Верхняя строка: время + статус
            HStack {
                Text(lesson.time)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                if lesson.status == .cancelled {
                    Text("Занятие отменено")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.red.opacity(0.1))
                        .foregroundColor(.red)
                        .cornerRadius(8)
                } else if lesson.status == .replacement {
                    Text("Замена")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.15))
                        .foregroundColor(.green)
                        .cornerRadius(8)
                } else if lesson.format == .online {
                    Text("Online")
                        .font(.caption)
                        .foregroundColor(.gray)
                } else if lesson.format == .offline {
                    
                    // Аудитория
                    if let room = lesson.room, lesson.format == .offline {
                        Text(room)
                            .font(.subheadline)
                            .foregroundColor(.primary)
                    }
                    
                }
                
            }
            
            Divider()
                    .frame(height: 1)
                    .background(.gray.opacity(0.3)) // или .gray.opacity(0.3)
                    //.padding(.top, 1)

            // Название
            Text(lesson.title)
                .font(.headline)
                .multilineTextAlignment(.leading)

            // Преподаватель + тип занятия
            HStack {
                Text(lesson.teacher)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text(lesson.type == .lecture ? "Лекция" : "Семинар")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

        }
        .padding()
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(borderColor(for: lesson), lineWidth: 1)
        )
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.03), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }

    private func borderColor(for lesson: Lesson) -> Color {
        switch lesson.status {
        case .active:
            return lesson.format == .online ? Color.purple.opacity(0.3) : Color.green
        case .cancelled:
            return Color.red
        case .replacement:
            return Color.green
        }
    }
}

struct LessonCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            LessonCardView(lesson: Lesson(
                title: "Иностранный язык",
                teacher: "Иванов И.И.",
                type: .lecture,
                format: .offline,
                status: .active,
                time: "10:45 — 12:20",
                room: "209 ауд."
            ))

            LessonCardView(lesson: Lesson(
                title: "Физика",
                teacher: "Петров П.П.",
                type: .seminar,
                format: .online,
                status: .cancelled,
                time: "13:00 — 14:30",
                room: nil
            ))

            LessonCardView(lesson: Lesson(
                title: "Математика",
                teacher: "Сидоров С.С.",
                type: .lecture,
                format: .offline,
                status: .replacement,
                time: "15:00 — 16:30",
                room: "101 ауд."
            ))
        }
    }
}

