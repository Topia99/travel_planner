//
//  DateCapsuleView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import SwiftUI

struct DateCapsuleView: View {
    
    var date: Date
    var isSelected: Bool
    
    var body: some View {
        ZStack {
            // Background based on selection state
            if isSelected {
                Color.brandPrimary
                    .cornerRadius(100)
            } else {
                BlurView(style: .systemUltraThinMaterial)
                    .cornerRadius(100)
            }
            
            // Text inside the capsule
            Text(isSelected ? DateUtils.formattedDate_WeekDay_Date(date) : DateUtils.formattedDate(date))
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .frame(height: 35)
        }
        .frame(width: isSelected ? 130 : 90, height: 35)
        .padding(3)
        .animation(.easeInOut(duration: 0.3), value: isSelected)
    }
}

#Preview {
    DateCapsuleView(date: Date.now,
                    isSelected: true)
}
