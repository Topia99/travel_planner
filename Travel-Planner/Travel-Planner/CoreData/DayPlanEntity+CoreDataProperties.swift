//
//  DayPlanEntity+CoreDataProperties.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/19/24.
//
//

import Foundation
import CoreData


extension DayPlanEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DayPlanEntity> {
        return NSFetchRequest<DayPlanEntity>(entityName: "DayPlanEntity")
    }

    @NSManaged public var date: Date
    @NSManaged public var dayNumber: Int16
    @NSManaged public var notes: String?
    @NSManaged public var title: String?
    @NSManaged public var activities: NSSet?
    @NSManaged public var trip: TripEntity
}

// MARK: Generated accessors for activities
extension DayPlanEntity {

    @objc(addActivitiesObject:)
    @NSManaged public func addToActivities(_ value: ActivityEntity)

    @objc(removeActivitiesObject:)
    @NSManaged public func removeFromActivities(_ value: ActivityEntity)

    @objc(addActivities:)
    @NSManaged public func addToActivities(_ values: NSSet)

    @objc(removeActivities:)
    @NSManaged public func removeFromActivities(_ values: NSSet)

}

extension DayPlanEntity : Identifiable {

}
