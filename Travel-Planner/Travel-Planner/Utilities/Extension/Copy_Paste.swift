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
        
        for dayPlan in dayPlans {
            exportText += "\nDate: \(DateUtilities.formattedDate_WeekDay_Date(dayPlan.date))\n"
            for item in dayPlan.items {
                let itemTitle = item.title
                let itemLocation = item.location ?? "No location specified"
                let itemTime = item.time != nil ? DateUtilities.formattedTimeOnly(item.time!) : "No time specified"
                let itemDescription = item.description ?? "No description provided"
                
                exportText += "- \(itemTitle)\n"
                exportText += "  Location: \(itemLocation)\n"
                exportText += "  Time: \(itemTime)\n"
                exportText += "  Description: \(itemDescription)\n"
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

