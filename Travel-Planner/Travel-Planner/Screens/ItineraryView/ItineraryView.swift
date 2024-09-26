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
                
                HScollDatesView(dayPlans: itinerary.dayPlans,
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

struct DateCapsuleView: View {
    
    var date: Date
    var isSelected: Bool
    
    var body: some View {
        Text(DateUtilities.formattedDate(date))
            .font(.system(size: 18))
            .fontWeight(.semibold)
            .frame(width: 145, height: 35)
            .background(isSelected ? Color.brandPrimary : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(100)
            .padding(3)
    }
}

struct HScollDatesView: View {
    
    var dayPlans: [DayPlan]
    @Binding var selectedDate: Date?
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(dayPlans){ dayPlan in
                    DateCapsuleView(date: dayPlan.date,
                                    isSelected: isSelected(date: dayPlan.date))
                    .onTapGesture {
                        selectedDate = dayPlan.date
                    }
                }
            }
        }
        .frame(height: 80)
    }
    
    func isSelected(date: Date) -> Bool {
        if let selectedDate = self.selectedDate {
            return Calendar.current.isDate(selectedDate, inSameDayAs: date)
        } else {
            return false
        }
    }
}
