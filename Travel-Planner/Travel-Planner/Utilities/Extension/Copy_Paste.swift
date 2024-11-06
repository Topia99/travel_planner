//
//  Copy_Paste.swift
//  Travel-Planner
//
//  Created by Aaron Lee on 11/3/24.
//

import Foundation
import UIKit

extension Trip {
    func exportAsText() -> String {
        var exportText = "Itinerary: \(title)\n"
        exportText += "Start Date: \(DateUtilities.formattedDate(startDate))\n"
        exportText += "End Date: \(DateUtilities.formattedDate(endDate))\n"
        exportText += "Destinations: \(destinations.joined(separator: ", "))\n"
        exportText += "\n--- Day Plans ---\n"
        
        for (index, dayPlan) in dayPlans.enumerated() {
            // Format Day and Date
            let dayNumber = index + 1
            let formattedDate = DateUtilities.formattedDate_WeekDay_Date(dayPlan.date)
            exportText += "\nDay \(dayNumber) (\(formattedDate)):\n"
            
            // Iterate over items for the day's itinerary
            for item in dayPlan.items {
                let itemTitle = item.title
                let itemLocation = item.location ?? "No location specified"
                let itemTime = item.time != nil ? DateUtilities.formattedTimeOnly(item.time!) : "No time specified"
                let itemDescription = item.description ?? "No description provided"
                
                // Customize for activity, food, and accommodation
                if itemTitle.lowercased().contains("dinner") || itemTitle.lowercased().contains("lunch") {
                    exportText += "🍽️ Food: \(itemTitle)\n"
                    exportText += "Time: \(itemTime)\n"
                    exportText += "Location: \(itemLocation)\n"
                    exportText += "Description: \(itemDescription)\n\n"
                } else if itemTitle.lowercased().contains("hotel") || itemTitle.lowercased().contains("accommodation") {
                    exportText += "🏨 Accommodation: \(itemTitle)\n"
                    exportText += "Check-In Time: \(itemTime)\n"
                    exportText += "Location: \(itemLocation)\n"
                    exportText += "Description: \(itemDescription)\n\n"
                } else {
                    // Apply 🎡 to any remaining activities
                    exportText += "🎡 Activity: \(itemTitle)\n"
                    exportText += "Time: \(itemTime)\n"
                    exportText += "Location: \(itemLocation)\n"
                    exportText += "Description: \(itemDescription)\n\n"
                }
            }
        }
        
        return exportText
    }
}


class ItineraryExporter {
    static func copyToClipboard(trip: Trip) {
        let itineraryText = trip.exportAsText()
        UIPasteboard.general.string = itineraryText
        print("Itinerary copied to clipboard.")
    }
}

