//
//  TripDateSection.swift
//  Travel-Planner
//
//  Created by siye yang on 10/14/24.
//

import SwiftUI

// View for selecting trip dates (start and end dates)
struct TripDateSection: View {
    // Binding variables to store the selected start and end dates
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    @Binding var isCalendarVisible: Bool // Controls the visibility of the calendar
    let calendar = Calendar.current // Reference to the current calendar
    
    var body: some View {
        Section(header: Text("What's your date duration")
            .foregroundColor(Color("darkGreen"))) {
                Button(action: {
                    withAnimation {
                        isCalendarVisible.toggle()
                    }
                }) {
                    HStack {
                        Text("   Date")
                        Spacer()
                        if let startDate = startDate, let endDate = endDate {
                            if calendar.isDate(startDate, inSameDayAs: endDate) {
                                // Display single date
                                Text("\(DateUtilities.formattedDate(startDate))  ")
                                    .foregroundColor(Color("darkGreen"))
                            } else {
                                // Display date range
                                Text("\(DateUtilities.formattedDateRange(start: startDate, end: endDate))  ")
                                    .foregroundColor(Color("darkGreen"))
                            }
                        } else {
                            Text("Select Date Range    ")
                                .foregroundColor(Color("darkGreen"))
                        }
                    }
                    .frame(width: 320, height: 60)
                    .background(Color("softGreen"))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("darkGreen"), lineWidth: 1)
                    )
                }
                .foregroundColor(Color("darkGreen"))
                
                // Conditionally show the calendar
                if isCalendarVisible {
                    CustomCalendarView(startDate: $startDate, endDate: $endDate)
                }
            }
    }
}

// Preview wrapper for TripDateSection to visualize the component in Xcode's preview canvas
struct TripDateSectionPreviewWrapper: View {
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var isCalendarVisible = true // Set to true to see the calendar in the preview

    var body: some View {
        NavigationStack {
            Form {
                TripDateSection(
                    startDate: $startDate,
                    endDate: $endDate,
                    isCalendarVisible: $isCalendarVisible
                )
            }
        }
    }
}

#Preview {
    TripDateSectionPreviewWrapper()
}
