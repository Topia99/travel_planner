//
//  HScrollDatesView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import SwiftUI

// A horizontally scrollable view displaying the dates of the trip.
struct HScrollDatesView: View {
    
    @Binding var dayPlans: [DayPlan]
    @Binding var selectedDayPlanIndex: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(dayPlans.indices, id: \.self){ index in
                    DateCapsuleView(date: dayPlans[index].date,
                                    isSelected: index == selectedDayPlanIndex)
                    .onTapGesture {
                        selectedDayPlanIndex = index // Update @Binding selectedDayPlanIndex when tap.
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 50)
    }
}

