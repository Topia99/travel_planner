//
//  ContentView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import SwiftUI
import Foundation



struct TripView: View {
    
    @EnvironmentObject var tripViewModel: TripViewModel
    
    @Binding var trip: Trip
    @State private var selectedDayPlanIndex: Int = 0

    var body: some View {
        
        VStack(spacing: 0) {
                   // HScrollDatesView at the top
                   HScrollDatesView(dayPlans: $trip.dayPlans,
                                    selectedIndex: $selectedDayPlanIndex)
                   HorizontalLine()
                   
                   // TabView fills the remaining space
                   TabView(selection: $selectedDayPlanIndex) {
                       ForEach(Array($trip.dayPlans.enumerated()), id: \.offset) { index, $dayPlan in
                           DayPlanView(dayPlan: $dayPlan)
                               .tag(index)
                       }
                   }
                   .tabViewStyle(.page(indexDisplayMode: .never))
                   .animation(.easeInOut(duration: 0.3), value: selectedDayPlanIndex)
                   .frame(maxWidth: .infinity, maxHeight: .infinity)
               }
               .navigationTitle("Trip Itinerary")
               .frame(maxWidth: .infinity, maxHeight: .infinity)
               .toolbar {
                   ToolbarItem(placement: .navigationBarTrailing) {
                       Button {
                           tripViewModel.saveTrips()
                       } label: {
                           Text("Save")
                               .foregroundColor(Color.brandPrimary)
                       }
                   }
               }
    }
}


//#Preview {
//    NavigationView {
//        TripView()
//    }
//}



struct AddItemButton: View {
    
    var body: some View {
    
        Text("Add Activity")
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 300, height: 50)
            .background(Color.brandPrimary)
            .foregroundColor(.white)
            .cornerRadius(10.0)
    }
}
