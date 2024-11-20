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
//    @State private var itemToEdit: Item? = nil // Holds the Item to be edited; nil if adding a new item.
    
    var body: some View {
        ScrollView{
            VStack {
                // Display the date of a dayplan. Ex: Nov 25
                DayPlanHeadingView(date: vm.dayPlan.date, dayNumber: vm.dayPlan.dayNumber)
                
                
//                // TextField input view for Title and description
//                DayPlanTitleAndDescriptionView(dayPlan: $dayPlan)
                
                
                
//                // Item List
//                DayPlanItemListView(items: $dayPlan.items) { item in
//                    itemToEdit = item // When a user taps on an existing item in the list, itemToEdit is set to the tapped item.
//                    isShowingItemDetail = true
//                }
                
                
                // Item List
                HStack{
                    VerticalLine()
                    VStack{
                        ForEach(vm.activities) { activity in
                            NavigationLink(destination: ActivityDetailView(activity: activity, vm: vm)) {
                                ItemCellView(activity: activity)
                            }
                        }
                    }
                }
                
                // Add new item button
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

