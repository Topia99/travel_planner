//
//  DateUtilities.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import Foundation

struct DateUtilities {
    
    // Convert Date to String with "Month(word) date(number)"format.
    // Input: 2023-05-19 07:30:00 +0000 -> "May 19"
    static func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: date)
    }
}
