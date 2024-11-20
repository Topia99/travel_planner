//
//  DayPlanTitleAndDescriptionView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/13/24.
//

import SwiftUI

struct DayPlanTitleAndDescriptionView: View {
    
    @ObservedObject var dayPlan: DayPlanEntity
    let coreDataManager = CoreDataManager.instance
    
    var body: some View {
        HStack{
            Text("Day \(dayPlan.dayNumber):")
            TextField("Day Title", text: Binding(
                get: { dayPlan.title ?? ""},
                set: { newValue in
                    dayPlan.title = newValue
                    coreDataManager.save()
                }
            ))
            
            Spacer()
        }
        .font(.title2)
        .fontWeight(.semibold)
        
        
        TextField("Day Description", text: Binding(
            get: { dayPlan.notes ?? ""},
            set: { newValue in
                dayPlan.notes = newValue
                coreDataManager.save()
            }
        ))
        .font(.body)
        .padding(.top, 3)
    }
}

