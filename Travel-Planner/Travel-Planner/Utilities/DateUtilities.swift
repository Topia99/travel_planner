//
//  DateUtilities.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import Foundation

struct DateUtils {
    
    
    // Convert Date to String with "Month(word) date(number)"format.
    // Input: 2023-05-19 07:30:00 +0000 -> "May 19"
    static func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: date)
    }
    
    static func formattedDate_WeekDay_Date(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMM d" // This outputs date as "Thu, Oct, 3
        return dateFormatter.string(from: date)
    }
    
    static func numberOfDaysBetweenTwoDates(_ startDate: Date, _ endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day ?? 0
    }
    
    static func formattedDate_WeekDay_Date_Year(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy" // This outputs date as "Thursday, Oct 3, 2024
        return dateFormatter.string(from: date)
    }
    
    static func formattedDateRange(start: Date, end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return "\(formatter.string(from: start)) — \(formatter.string(from: end))"
    }
}
