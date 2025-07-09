//
//  MainTabView.swift
//  UniFlow
//
//  Created by Алия Гумирова on 02.07.2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ScheduleView()
                .tabItem {
                    Label("Расписание", systemImage: "calendar")
                }

            Text("Оценки")
                .tabItem {
                    Label("Оценки", systemImage: "star")
                }

            Text("Профиль")
                .tabItem {
                    Label("Профиль", systemImage: "person")
                }
        }
    }
}

#Preview {
    MainTabView()
}

