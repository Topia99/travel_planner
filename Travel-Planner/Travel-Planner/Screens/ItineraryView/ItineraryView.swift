//
//  ContentView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import SwiftUI
import Foundation



struct ItineraryView: View {
    
    let itinerary = MockData.sampleItinerary
    @State private var selectedDates: Date? = nil
    
    init() {
           // Set the default selected date to the first day's date in the itinerary
           _selectedDates = State(initialValue: itinerary.dayPlans.first?.date)
    }
    
    
    var body: some View {
        NavigationView{
            VStack{
                
                HScrollDatesView(dayPlans: itinerary.dayPlans,
                                selectedDate: $selectedDates)
                
                Spacer()
                
                Text("Hi")
                
            }
            .navigationTitle("🏝️ Itinerary")
        }
    }
}

#Preview {
    ItineraryView()
}

