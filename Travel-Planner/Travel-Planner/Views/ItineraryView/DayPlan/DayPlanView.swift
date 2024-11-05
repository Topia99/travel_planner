//
//  DayPlanView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//

import SwiftUI

struct DayPlanView: View {
    
    @ObservedObject var dayPlanViewModel: DayPlanViewModel
    
    @State var isShowingAddActivity: Bool = false // Controls the presentation of the TripItemDetail sheet.
//    @State private var itemToEdit: Item? = nil // Holds the Item to be edited; nil if adding a new item.
    
    var body: some View {
        ScrollView{
            VStack {
                // Display the date of a dayplan. Ex: Nov 25
                DayPlanHeadingView(date: dayPlanViewModel.dayPlan.date, dayNumber: dayPlanViewModel.dayPlan.dayNumber)
                
                
                // TextField input view for Title and description
                DayPlanTitleAndDescriptionView(dayPlan: $dayPlanViewModel.dayPlan)
                
                
                
                // Item List
//                DayPlanItemListView(items: $dayPlanViewModel.items) { item in
//                    itemToEdit = item // When a user taps on an existing item in the list, itemToEdit is set to the tapped item.
//                    isShowingItemDetail = true
//                }
                
                DayPlanItemListView(dayPlanViewModel: dayPlanViewModel)
                
                // Add new item button
                Button {
//                    itemToEdit = nil // No item to edit; we're adding a new item
                    isShowingAddActivity = true
                } label: {
                    AddItemButton()
                }
                
            }
            .padding()
            .sheet(isPresented: $isShowingAddActivity) {
                NavigationStack {
                    
//                    AddActivityView() { newActivity in
//                        dayPlan.items.append(newActivity)
//                    }
                    
                    
//                    TripItemDetail(itemToEdit: itemToEdit) { newItem in // newItem pass from TripItemDetail onSave closure
//                        
//                        /* The onSave closure handles both updating existing items and adding
//                         new ones based on whether the item's id exists in dayPlan.items */
//                        if let index = dayPlan.items.firstIndex(where: { $0.id == newItem.id}) { // Check if newItem idex exist in dayPlan.items
//                            // Existing item found; update it
//                            dayPlan.items[index] = newItem
//                        } else {
//                            // No existing item with this id; add it as a new item
//                            dayPlan.items.append(newItem)
//                        }
//                    }
                }
//                .presentationDetents([.medium]) // sheet view only expand 1/3 of the screen.
            }
        }
    }
}

