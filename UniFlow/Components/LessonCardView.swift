//
//  LessonCardView.swift
//  UniFlow
//
//  Created by Алия Гумирова on 02.07.2025.
//
import SwiftUI

struct LessonCardView: View {
    // UI делает авто инит под структуру каждого нового объекта?
    let lesson: Lesson

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Верхняя строка: время + статус
            HStack {
                Text(lesson.time)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                // Надо менять в зависимости от бека
                if lesson.status {
                   if lesson.format.lowercased() == "online" {
                       Text("Online")
                           .font(.caption)
                           .foregroundColor(.gray)
                   } else if lesson.format.lowercased() == "offline" {
                       if let room = lesson.room {
                           Text(room)
                               .font(.subheadline)
                               .foregroundColor(.primary)
                       }
                   }
                } else {
                    if lesson.format.lowercased() == "Замена" {
                        Text("Online")
                            .font(.caption)
                            .foregroundColor(.gray)
                    } else {
                        Text("Занятие отменено")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.red.opacity(0.1))
                            .foregroundColor(.red)
                            .cornerRadius(8)
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
                Text(lesson.type)
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
        case true:
            return lesson.format == "online" ? Color.purple.opacity(0.3) : Color.green
        case false:
            return Color.red
        }
    }
}

struct LessonCardView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 16) {
            LessonCardView(lesson: <#T##Lesson#>)
        }
    }
}

