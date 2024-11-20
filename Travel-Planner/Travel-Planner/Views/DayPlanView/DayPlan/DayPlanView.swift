//
//  DayPlanView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//

import SwiftUI

struct DayPlanView: View {
    
    @StateObject var vm: ActivityViewModel
    @State var isShowingAddActivity: Bool = false // Controls the presentation of the TripItemDetail sheet.
    
    var body: some View {
        ScrollView{
            VStack {
                // Display the date of a dayplan. Ex: Nov 25
                DayPlanHeadingView(date: vm.dayPlan.date, dayNumber: vm.dayPlan.dayNumber)
                
                // TextField input view for Title and description
                DayPlanTitleAndDescriptionView(dayPlan: vm.dayPlan)
                
                // Activity List
                HStack{
                    VerticalLine()
                    VStack{
                        ForEach(vm.activities) { activity in
                            NavigationLink(destination: ActivityDetailView(activity: activity, vm: vm)) {
                                ActivityCellView(activity: activity)
                            }
                        }
                    }
                }
                
                // Add new activity button
                Button {
                    isShowingAddActivity = true
                } label: {
                    AddItemButton()
                }
                
            }
            .padding()
            .sheet(isPresented: $isShowingAddActivity) {
                NavigationStack {
                    AddActivityView(vm: vm)
                }
            }
        }
    }
}

