//
//  ContentView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import SwiftUI

struct TripView: View {
    @StateObject var vm: DayPlanViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var navigateToChatView = false
    @State private var selectedDayPlanIndex: Int = 0 // This state variable keeps track of the currently selected day plan index
    
    var body: some View {
        
        VStack(spacing: 0) {
            // A horizontally scrollable view displaying the dates of the trip.
            HScrollDatesView(dayPlans: vm.dayPlans,
                             selectedDayPlanIndex: $selectedDayPlanIndex)
//            HorizontalLine()
            
            // A swipeable view that shows the detailed content of each day plan.
            TabView(selection: $selectedDayPlanIndex) { // $selectedDayPlanIndex get update when TabView's selected page changes
                ForEach(Array(vm.dayPlans.enumerated()), id: \.offset) { index, dayPlan in
                    DayPlanView(vm: ActivityViewModel(dayPlan: dayPlan))
                        .tag(index) // This assigns a unique identifier (the index) to each DayPlanView within the TabView
                    /* When the TabView displays a particular DayPlanView, it checks the tag of that view. If the tag matches the value of selectedDayPlanIndex, that view is displayed. Conversely, when the user swipes to a different tab, the TabView updates selectedDayPlanIndex to match the tag of the newly displayed view.*/
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut(duration: 0.3), value: selectedDayPlanIndex) // Slide animation when switch to different day.
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationTitle(vm.trip.title)
        .navigationBarTitleDisplayMode(.automatic)
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .toolbar {
            // Custom Back Button
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss() // Programmatically navigate back
                }) {
                    HStack {
                        Image(systemName: "arrow.backward")
                        Text("Back")
                    }
                    .foregroundColor(Color.white)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                HStack{
                    // Button navigate to ChatView
                    Button(action: {
                        navigateToChatView = true
                    }) {
                        Image(systemName: "atom")
                            .foregroundColor(Color.white)
                    }
                    
                    ShareLink(item: vm.trip.exportAsText(), subject: Text("Share your Trip Itinerary"))
                        .foregroundColor(Color.white)
                }
            }
        }
        // Navigation link to ChatView
        .navigationDestination(isPresented: $navigateToChatView) {
            ChatView(vm: ChatViewModel(itinerary: vm.trip.exportAsText()))
        }
        .background(
            Image("Theme3") // Use the Theme1 image asset
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .scaledToFill()
        )
    }
}




