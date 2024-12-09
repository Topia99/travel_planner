//
//  ActivityTypePickerView.swift
//  Travel-Planner
//
//  Created by siye yang on 12/3/24.
//

import SwiftUI

struct ActivityTypePickerView: View {
    @Binding var selectedActivityType: ActivityType

    var body: some View {
        Picker("Type", selection: $selectedActivityType) {
            ForEach(ActivityType.allCases, id: \.self) { type in
                HStack {
                    Label {
                        Text(type.displayName)
                    } icon: {
                        Image(systemName: type.iconName)
                            .foregroundStyle(.white, type.iconColor)
                    }
                }
                .tag(type)
            }
        }
        .pickerStyle(MenuPickerStyle())
    }
}
