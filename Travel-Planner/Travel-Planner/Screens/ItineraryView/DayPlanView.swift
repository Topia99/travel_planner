//
//  DayPlanView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//

import SwiftUI

struct DayPlanView: View {
    
    @Binding var dayPlan: DayPlan
    
    var body: some View {
        
        
        VStack {
            // DayPlan Date Heading View
            DayPlanHeadingView(date: dayPlan.date, dayNumber: dayPlan.dayNumber)
            
            // DayPlan title and description View
            DayPlanTitleView(dateNumber: dayPlan.dayNumber,
                             title: dayPlan.title,
                             description: dayPlan.description)
            
            DayPlanItemListView(items: $dayPlan.items)
            
        }
    }
}

#Preview {
    DayPlanView(dayPlan: .constant(DayPlan(title: "Day 1: Arrival and City Tour", description: "Explore the city and enjoy the local food.", dayNumber: 1, date: Date(), items: [
        Item(title: "Breakfast", time: "08:00 AM", description: "Morning breakfast at hotel", location: "Hotel Restaurant", type: .food),
        Item(title: "City Tour", time: "10:00 AM", description: "Explore the main sights of the city", location: "City Center", type: .activity),
        Item(title: "Lunch", time: "12:00 PM", description: "Lunch at a popular restaurant", location: "Downtown", type: .food)
    ])))
}
