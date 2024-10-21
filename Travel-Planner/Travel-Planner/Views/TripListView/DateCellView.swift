//
//  DateCell.swift
//  TravelPlanner
//
//  Created by siye yang on 9/23/24.
//
import SwiftUI

// View representing a single date cell in a calendar
struct DateCellView: View {
    let date: Date // The specific date for the cell
    @Binding var startDate: Date? // Binding to the selected start date
    @Binding var endDate: Date? // Binding to the selected end date
    let currentMonth: Date // The current month being displayed in the calendar
    
    // Reference to the current calendar
    var calendar = Calendar.current
    
    var body: some View {
        // Determine if the date is within the current month
        let isInCurrentMonth = calendar.isDate(date, equalTo: currentMonth, toGranularity: .month)
        // Check if the date is selected as start or end date
        let isSelected = isSelectedDate(date)
        // Check if the date falls within the selected date range
        let isInRange = isDateInRange(date)
        // Check if the date is today's date
        let isToday = calendar.isDateInToday(date)
        // Check if the date is in the past
        let isPastDate = date < Date().startOfDay

        // Display the day number in the cell
        Text("\(calendar.component(.day, from: date))")
            .font(.system(size: 14)) // Set the font size for the date
            .frame(maxWidth: .infinity, minHeight: 40) // Ensure the text takes up space with min height
            .padding(4) // Padding around the text
            
            // Set background color based on the date's status
            .background(
                isSelected ? Color.blue : // If selected, show blue background
                (isInRange ? Color.blue.opacity(0.3) : // If in range, show lighter blue
                (isToday ? Color.gray.opacity(0.3) : Color.clear)) // If today, show gray background
            )
            
            // Set text color based on the date's status
            .foregroundColor(
                isInCurrentMonth ? (isSelected || isInRange ? Color.white : // White if selected or in range
                (isPastDate ? Color.gray : Color.primary)) : // Gray if in past, otherwise default color
                Color.gray // Gray color for dates not in the current month
            )
            
            // Apply a rounded corner style to the date cell
            .cornerRadius(8)
            
            // Disable the cell if it's a past date
            .disabled(isPastDate)
    }
    
    // Check if the current date is the selected start or end date
    func isSelectedDate(_ date: Date) -> Bool {
        if let start = startDate, calendar.isDate(date, inSameDayAs: start) {
            return true // Return true if the date matches the start date
        }
        if let end = endDate, calendar.isDate(date, inSameDayAs: end) {
            return true // Return true if the date matches the end date
        }
        return false // Return false if not selected
    }
    
    // Check if the date falls within the range between the start and end dates
    func isDateInRange(_ date: Date) -> Bool {
        if let start = startDate, let end = endDate {
            return date > start && date < end // Return true if the date is in the range
        }
        return false // Return false if not in the range
    }
}

extension Date {
    // Extension to get the start of the day for a given date
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self) // Return the start of the day
    }
}
