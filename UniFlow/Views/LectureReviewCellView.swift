//
//  LectureReviewCellView.swift
//  UniFlow
//
//  Created by Алия Гумирова on 17.07.2025.
//

import SwiftUI

struct LectureReviewCellView: View {
    let item: NotificationItem

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 8) {
                if item.isNew {
                    Circle()
                        .fill(Color.pink)
                        .frame(width: 10, height: 10)
                        .padding(.top, 4)
                }

                VStack(alignment: .leading, spacing: 6) {
                    // Заголовок и время
                    HStack {
                        Text(item.title)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color("textPrimary"))

                        Spacer()

                        HStack(spacing: 4) {
                            Text(item.time)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)

                            if case .lectureReview(let isRated, _) = item.type, !isRated {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                            }
                        }
                    }

                    // Дата лекции (захардкожено)
                    Text("Лекция 14.08.25")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)

                    // Сообщение из типа
                    if case .lectureReview(_, let message) = item.type {
                        Text(message)
                            .font(.system(size: 14))
                            .foregroundColor(Color("textPrimary"))
                    }

                    // Оценка, если есть
                    if case .lectureReview(let isRated, _) = item.type, isRated, let rating = item.rating {
                        HStack(spacing: 4) {
                            ForEach(1...5, id: \.self) { index in
                                Image(systemName: index <= rating ? "star.fill" : "star")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(index <= rating ? Color.orange : Color.gray.opacity(0.4))
                            }
                        }
                        .padding(.top, 4)
                    }
                }
            }
            .padding(12)
            .background(item.isNew ? Color("VioletLight") : Color.white)
            .cornerRadius(18)
        }
    }
}
