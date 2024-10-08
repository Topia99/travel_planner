//
//  DateplanTitle.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/2/24.
//

import SwiftUI

struct DayPlanTitleView: View {
    var dateNumber: Int
    var title: String?
    var description: String?
    
    var body: some View {
        
        VStack (alignment: .leading) {
            // DayPlan Title
            HStack{
                Text("Day \(dateNumber):")
                if let title {
                    Text(title)
                        .lineLimit(1)
                }
                Spacer()

            }
            .font(.title2)
            .fontWeight(.semibold)
            
            // DayPlan Description
            if let description {
                Text(description)
                    .font(.body)
                    .padding(.top, 3)
            }
        }
    }
}

#Preview {
    DayPlanTitleView(dateNumber: 1, title: "On the road to Lake Tahoe", description: "Leave home and head to Lake Tahoe. Take a scenic drive along the Tahoe Rim Highway, stopping at scenic overlooks along the way.")
}
