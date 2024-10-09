//
//  CustomCalendarView.swift
//  TravelPlanner
//
//  Created by siye yang on 9/24/24.
//

import SwiftUI

struct CustomCalendarView: View {
    @Binding var startDate: Date?
    @Binding var endDate: Date?

    @State private var currentMonth: Date = Date()

    let calendar = Calendar.current
    let dateFormatter = DateFormatter()

    var body: some View {
        VStack {
            // Month Navigation
            HStack {
                Button(action: {
                    previousMonth()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())

                Spacer()

                Text(monthYearString(from: currentMonth))
                    .font(.headline)

                Spacer()

                Button(action: {
                    nextMonth()
                }) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)

            // Days of the Week Labels
            HStack {
                ForEach(calendar.shortWeekdaySymbols, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                }
            }

            // Dates Grid
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(daysInCurrentMonth, id: \.self) { date in
                    DateCellView(date: date, startDate: $startDate, endDate: $endDate, currentMonth: currentMonth)
                        .onTapGesture {
                            handleDateTap(date)
                        }
                }
            }
        }
    }

    // Computed property for days in the current month
    var daysInCurrentMonth: [Date] {
        generateDaysInMonth(for: currentMonth)
    }

    // Helper methods
    func generateDaysInMonth(for date: Date) -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date),
              let firstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start) else {
            return []
        }

        var days: [Date] = []
        var currentDate = firstWeek.start

        // Include dates from the previous and next months to fill the calendar grid
        while currentDate <= monthInterval.end || calendar.isDate(currentDate, equalTo: monthInterval.end, toGranularity: .day) {
            days.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }

        return days
    }

    func monthYearString(from date: Date) -> String {
        dateFormatter.dateFormat = "LLLL yyyy"
        return dateFormatter.string(from: date)
    }

    func previousMonth() {
        if let newDate = calendar.date(byAdding: .month, value: -1, to: currentMonth) {
            currentMonth = newDate
        }
    }

    func nextMonth() {
        if let newDate = calendar.date(byAdding: .month, value: 1, to: currentMonth) {
            currentMonth = newDate
        }
    }

    // Updated handleDateTap function
    func handleDateTap(_ date: Date) {
        if calendar.compare(date, to: Date(), toGranularity: .day) == .orderedAscending {
            // Do not allow selection of past dates (optional)
            return
        }

        if startDate == nil {
            // First tap sets the start date
            startDate = date
            endDate = nil
        } else if endDate == nil {
            // Second tap
            if date <= startDate! {
                // Update startDate to the earlier date
                startDate = date
            } else if date > startDate! {
                // Set endDate
                endDate = date
            } else {
                // Date is the same as startDate, do nothing or reset selection
                // For this example, we will do nothing
            }
        } else {
            // If both startDate and endDate are set, reset the selection
            startDate = date
            endDate = nil
        }
    }
}
