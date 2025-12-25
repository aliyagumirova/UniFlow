//
//  NotificationsView.swift
//  UniFlow
//
//  Created by Алия Гумирова on 17.07.2025.


import SwiftUI

struct NotificationsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = NotificationsViewModel()
    @State private var selectedTab = 0

    var filteredNotifications: [NotificationItem] {
        selectedTab == 0 ? viewModel.allNotifications : viewModel.lectureReviewNotifications
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 4) {
                Button(action: { selectedTab = 0 }) {
                    Text("Все \(viewModel.allNotifications.count)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(selectedTab == 0 ? .white : Color("textSecondary"))
                        .frame(width: 175, height: 30)
                        .background(selectedTab == 0 ? Color("Violet") : Color.white)
                        .cornerRadius(14)
                }

                Button(action: { selectedTab = 1 }) {
                    Text("Оценка лекций \(viewModel.lectureReviewNotifications.count)")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(selectedTab == 1 ? .white : Color("textSecondary"))
                        .frame(width: 169, height: 30)
                        .background(selectedTab == 1 ? Color("Violet") : Color.white)
                        .cornerRadius(14)
                }
            }
            .padding(6)
            .background(Color.white)
            .cornerRadius(16)
            .frame(width: 348, height: 34)
            .padding(.top, 8)
            .padding(.bottom, 12)

            //Список уведомлений
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(filteredNotifications) { item in
                        if case .lectureReview = item.type {
                            LectureReviewCellView(item: item)
                                .onTapGesture {
                                    if case .lectureReview(let isRated, _) = item.type, !isRated {
                                        viewModel.selectedNotification = item
                                    }
                                }
                        } else {
                            NotificationCellView(item: item)
                        }
                    }
                }
                .padding(.top, 8)
                .padding(.horizontal, 16)
            }

            Spacer(minLength: 0)
        }
        .background(Color("bgLight").ignoresSafeArea())
        .navigationTitle("Уведомления")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $viewModel.selectedNotification) { item in
            LectureRatingSheetView(viewModel: viewModel, notification: item)
        }
    }
}
