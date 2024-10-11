//
//  HScrollDatesView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import SwiftUI

struct HScrollDatesView: View {
    
    @Binding var dayPlans: [DayPlan]
    @Binding var selectedIndex: Int
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(dayPlans.indices, id: \.self){ index in
                    DateCapsuleView(date: dayPlans[index].date,
                                    isSelected: index == selectedIndex)
                    .onTapGesture {
                        selectedIndex = index
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 50)
    }
}

//#Preview {
//    HScrollDatesView(dayPlans: MockData.sampleItinerary.dayPlans, selectedDate: .constant(Date.now))
//}
