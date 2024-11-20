//
//  TripEntity+CoreDataProperties.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/19/24.
//
//

import Foundation
import CoreData


extension TripEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripEntity> {
        return NSFetchRequest<TripEntity>(entityName: "TripEntity")
    }

    @NSManaged public var endDate: Date
    @NSManaged public var startDate: Date
    @NSManaged public var title: String
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

}
