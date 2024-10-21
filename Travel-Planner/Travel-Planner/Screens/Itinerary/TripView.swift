//
//  ContentView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import SwiftUI



struct TripView: View {
    
    @EnvironmentObject var tripViewModel: TripViewModel
    
    @Binding var trip: Trip
    @State private var selectedDayPlanIndex: Int = 0 // This state variable keeps track of the currently selected day plan index
                                                     // It is crucial because it is bound to both the HScrollDatesView and the TabView,
                                                     // ensuring they remain in sync.
    
    var body: some View {
        
        VStack(spacing: 0) {
            // A horizontally scrollable view displaying the dates of the trip.
            HScrollDatesView(dayPlans: $trip.dayPlans,
                             selectedDayPlanIndex: $selectedDayPlanIndex)
            HorizontalLine()
            
            // A swipeable view that shows the detailed content of each day plan.
            TabView(selection: $selectedDayPlanIndex) { // $selectedDayPlanIndex get update when TabView's selected page changes
                ForEach(Array($trip.dayPlans.enumerated()), id: \.offset) { index, $dayPlan in
                    DayPlanView(dayPlan: $dayPlan)
                        .tag(index) // This assigns a unique identifier (the index) to each DayPlanView within the TabView
                    /* When the TabView displays a particular DayPlanView, it checks the tag of that view. If the tag matches the value of selectedDayPlanIndex, that view is displayed. Conversely, when the user swipes to a different tab, the TabView updates selectedDayPlanIndex to match the tag of the newly displayed view.*/
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut(duration: 0.3), value: selectedDayPlanIndex) // Slide animation when switch to different day.
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
//        .background(Color("creamWhite"))
        .navigationTitle(trip.title)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    tripViewModel.saveTrips() // Save changes to user defualt.
                } label: {
                    Text("Save")
                        .foregroundColor(Color.brandPrimary)
                }
            }
        }
    }
}




