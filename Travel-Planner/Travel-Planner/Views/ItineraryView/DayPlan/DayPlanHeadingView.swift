//
//  DayPlanHeading.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/2/24.
//

import SwiftUI

struct DayPlanHeadingView: View {
    
    let date: Date
    let dayNumber: Int
    
    var body: some View {
        // DayPlan Date
        HStack(alignment: .firstTextBaseline) {
            Text(DateUtilities.formattedDate(date))
                .font(.title)
                .fontWeight(.semibold)
            
            LabelledDivider(label: "day \(dayNumber)")
        }
    }
}

#Preview {
    DayPlanHeadingView(date: Date(), dayNumber: 1)
}
