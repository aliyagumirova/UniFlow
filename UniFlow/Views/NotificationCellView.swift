//
//  NotificationCellView.swift
//  UniFlow
//
//  Created by Алия Гумирова on 17.07.2025.
//

import SwiftUI

struct NotificationCellView: View {
    let item: NotificationItem

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 8) {
                if item.isNew {
                    Circle()
                        .fill(Color("StatusRed"))
                        .frame(width: 10, height: 10)
                        .padding(.top, 4)
                }

                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(item.title)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color("textPrimary"))

                        Spacer()

                        Text(item.time)
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                    }

                    Text(item.message)
                        .font(.system(size: 14))
                        .foregroundColor(Color("textPrimary"))
                }
            }
            .padding(12)
            .background(item.isNew ? Color("VioletLight") : Color.white)
            .cornerRadius(18)
        }
    }
}
