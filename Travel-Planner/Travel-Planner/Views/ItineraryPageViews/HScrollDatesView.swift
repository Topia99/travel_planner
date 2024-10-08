//
//  HScrollDatesView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import SwiftUI

struct HScrollDatesView: View {
    
    @Binding var dayPlans: [DayPlan]
    @Binding var selectedDate: Date?
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(dayPlans){ dayPlan in
                    DateCapsuleView(date: dayPlan.date,
                                    isSelected: isSelected(date: dayPlan.date))
                    .onTapGesture {
                        selectedDate = dayPlan.date
                    }
                }
            }
        }
        .frame(height: 50)
    }
    
    func isSelected(date: Date) -> Bool {
        if let selectedDate = self.selectedDate {
            return Calendar.current.isDate(selectedDate, inSameDayAs: date)
        } else {
            return false
        }
    }
}

//#Preview {
//    HScrollDatesView(dayPlans: MockData.sampleItinerary.dayPlans, selectedDate: .constant(Date.now))
//}
