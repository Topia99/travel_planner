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
            
//            // TextField input view for Title and description
//            DayPlanTitleAndDescriptionView(dayPlan: vm.dayPlan)
            
            List {
//                DayPlanHeadingView(date: vm.dayPlan.date, dayNumber: vm.dayPlan.dayNumber)
//                    .listRowSeparator(.hidden)
//                    .listRowBackground(Color.clear)
                
                ForEach(vm.activities) { activity in
                    Button(action: {
                        selectedActivity = activity
                    }) {
                        ActivityCellView(activity: activity)
                    }
                    .listRowBackground(Color.clear)
                    .padding(.vertical, 2)
                    
                    
                }
                .onMove(perform: vm.moveActivity)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
//                .listRowBackground(Color.clear)
            }
            .contentMargins(.vertical, 0)
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.clear)
            
            // Add new activity button
            Button {
                isShowingAddActivity = true
            } label: {
                AddItemButton()
            }
            .padding(.top)
        }
        .padding(.horizontal)
        .background(Color.clear)
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

