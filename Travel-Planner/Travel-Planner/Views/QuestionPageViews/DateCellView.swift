//
//  DateCell.swift
//  TravelPlanner
//
//  Created by siye yang on 9/23/24.
//
import SwiftUI

struct DateCellView: View {
    let date: Date
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    let currentMonth: Date
    
    var calendar = Calendar.current
    
    var body: some View {
        let isInCurrentMonth = calendar.isDate(date, equalTo: currentMonth, toGranularity: .month)
        let isSelected = isSelectedDate(date)
        let isInRange = isDateInRange(date)
        let isToday = calendar.isDateInToday(date)
        let isPastDate = date < Date().startOfDay
    
        Text("\(calendar.component(.day, from: date))")
            .font(.system(size: 14)) // Adjust font size if needed
            .frame(maxWidth: .infinity, minHeight: 40)
            .padding(4)
            .background(
                isSelected ? Color.blue :
                (isInRange ? Color.blue.opacity(0.3) :
                (isToday ? Color.gray.opacity(0.3) : Color.clear))
            )
            .foregroundColor(
                isInCurrentMonth ? (isSelected || isInRange ? Color.white : (isPastDate ? Color.gray : Color.primary)) : Color.gray
            )
            .cornerRadius(8)
            .disabled(isPastDate)
    }
    
    func isSelectedDate(_ date: Date) -> Bool {
        if let start = startDate, calendar.isDate(date, inSameDayAs: start) {
            return true
        }
        if let end = endDate, calendar.isDate(date, inSameDayAs: end) {
            return true
        }
        return false
    }
    
    func isDateInRange(_ date: Date) -> Bool {
        if let start = startDate, let end = endDate {
            return date > start && date < end
        }
        return false
    }
}

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
