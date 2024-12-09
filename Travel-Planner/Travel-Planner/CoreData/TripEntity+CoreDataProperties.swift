//
//  TripEntity+CoreDataProperties.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/19/24.
//
//

import Foundation
import CoreData
import UIKit


extension TripEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripEntity> {
        return NSFetchRequest<TripEntity>(entityName: "TripEntity")
    }

    @NSManaged public var endDate: Date
    @NSManaged public var startDate: Date
    @NSManaged public var title: String
    @NSManaged public var createdAt: Date
    @NSManaged public var dayPlans: NSSet?

}

// MARK: Generated accessors for dayPlans
extension TripEntity {

    @objc(addDayPlansObject:)
    @NSManaged public func addToDayPlans(_ value: DayPlanEntity)

    @objc(removeDayPlansObject:)
    @NSManaged public func removeFromDayPlans(_ value: DayPlanEntity)

    @objc(addDayPlans:)
    @NSManaged public func addToDayPlans(_ values: NSSet)

    @objc(removeDayPlans:)
    @NSManaged public func removeFromDayPlans(_ values: NSSet)

}

extension TripEntity : Identifiable {
    func exportAsText() -> String {
            var exportText = "Itinerary: \(title)\n"
            exportText += "Start Date: \(DateUtils.formattedDate(startDate))\n"
            exportText += "End Date: \(DateUtils.formattedDate(endDate))\n"
            exportText += "\n--- Day Plans ---\n"
        
            let dayPlansArray = (dayPlans?.allObjects as? [DayPlanEntity] ?? []).sorted { $0.dayNumber < $1.dayNumber }
            
            for (index, dayPlan) in dayPlansArray.enumerated() {
                // Format Day and Date
                let dayNumber = index + 1
                let formattedDate = DateUtils.formattedDate_WeekDay_Date(dayPlan.date)
                exportText += "\nDay \(dayNumber) (\(formattedDate)):\n"
                
                let activitiesArray = (dayPlan.activities?.allObjects as? [ActivityEntity] ?? []).sorted { $0.order < $1.order}
                
                // Iterate over items for the day's itinerary
                for activity in activitiesArray {
                    let itemTitle = activity.title
                    let itemLocation = activity.location ?? "No location specified"
                    let itemTime = activity.time != nil ? DateUtils.formattedTimeOnly(activity.time!) : "No time specified"
                    let itemDescription = activity.notes ?? "No description provided"

                    switch activity.type {
                    case .food:
                        exportText += "🍽️ Food: \(itemTitle)\n"
                        exportText += "Time: \(itemTime)\n"
                        exportText += "Location: \(itemLocation)\n"
                        exportText += "Description: \(itemDescription)\n\n"
                    case .accommodation:
                        exportText += "🏨 Accommodation: \(itemTitle)\n"
                        exportText += "Check-In Time: \(itemTime)\n"
                        exportText += "Location: \(itemLocation)\n"
                        exportText += "Description: \(itemDescription)\n\n"
                    case .activity:
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



