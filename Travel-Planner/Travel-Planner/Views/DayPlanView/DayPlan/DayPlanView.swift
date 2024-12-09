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
    @State private var selectedActivity: ActivityEntity? = nil

    var body: some View {
    
        VStack (spacing: 0) {
            // Display the date of a dayplan. Ex: Nov 25
            DayPlanHeadingView(date: vm.dayPlan.date, dayNumber: vm.dayPlan.dayNumber)
            
//            // TextField input view for Title and description
//            DayPlanTitleAndDescriptionView(dayPlan: vm.dayPlan)
            
            List {
                ForEach(vm.activities) { activity in
                    Button(action: {
                        selectedActivity = activity
                    }) {
                        ActivityCellView(activity: activity)
                    }
                }
                .onMove(perform: vm.moveActivity)
                
                // Add new activity button
                Button {
                    isShowingAddActivity = true
                } label: {
                    AddItemButton()
                }
                
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListHeaderHeight, 0)
        }
        .padding()
        .sheet(isPresented: $isShowingAddActivity) {
            NavigationStack {
                AddActivityView(vm: vm)
            }
        }
        .navigationDestination(item: $selectedActivity) { activity in
            ActivityDetailView(activity: activity, vm: vm)
        }
    }
}

