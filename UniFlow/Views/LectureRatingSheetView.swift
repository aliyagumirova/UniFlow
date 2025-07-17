//
//  LectureRatingSheetView.swift
//  UniFlow
//
//  Created by Алия Гумирова on 17.07.2025.
//

import SwiftUI

struct LectureRatingSheetView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: NotificationsViewModel
    let notification: NotificationItem

    @State private var selectedRating: Int = 0

    var body: some View {
        VStack(spacing: 16) {
            Spacer().frame(height: 32)

            Text("Как прошла лекция?")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(Color("textPrimary"))

            Text("Ваше мнение важно! Оцените занятие, чтобы сделать курс лучше.")
                .font(.system(size: 14))
                .foregroundColor(Color("textSecondary"))
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // Рейтинг
            HStack(spacing: 12) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= selectedRating ? "star.fill" : "star")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(index <= selectedRating ? Color.orange : Color.gray.opacity(0.3))
                        .onTapGesture {
                            selectedRating = index
                            viewModel.markNotification(notification, withRating: index)
                            dismiss()
                        }
                }
            }
            .padding(.top)

            Spacer()

            // Кнопка "Оценить"
            Button("Оценить") {
                if selectedRating > 0 {
                    viewModel.markNotification(notification, withRating: selectedRating)
                    dismiss()
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("Violet"))
            .foregroundColor(.white)
            .cornerRadius(20)
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
        .background(Color("bgLight"))
        .cornerRadius(20)
        .presentationDetents([.medium])
    }
}
