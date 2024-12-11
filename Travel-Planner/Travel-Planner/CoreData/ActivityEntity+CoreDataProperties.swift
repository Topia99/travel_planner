//
//  ActivityEntity+CoreDataProperties.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/19/24.
//
//

import Foundation
import SwiftUI
import CoreData


extension ActivityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityEntity> {
        return NSFetchRequest<ActivityEntity>(entityName: "ActivityEntity")
    }
    
    @NSManaged public var order: Int16
    @NSManaged public var createdAt: Date
    @NSManaged public var location: String?
    @NSManaged public var notes: String?
    @NSManaged public var time: Date?
    @NSManaged public var title: String
    @NSManaged public var type: ActivityType
    @NSManaged public var dayPlan: DayPlanEntity
    @NSManaged public var trip: TripEntity
}

extension ActivityEntity : Identifiable {

}

@objc
public enum ActivityType: Int16 {
    case activity
    case food
    case accommodation
}

extension ActivityType: CaseIterable {
    public static var allCases: [ActivityType] {
        return [.activity, .food, .accommodation]
    }
}

extension ActivityType: Hashable {}

extension ActivityType {
    var displayName: String {
        switch self {
        case .activity:
            return "Activity"
        case .food:
            return "Food"
        case .accommodation:
            return "Accommodation"
        }
    }
    
    var iconName: String {
        switch self {
        case .food:
            return "fork.knife"
        case .accommodation:
            return "house.fill"
        case .activity:
            return "location.circle"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .food:
            return Color.orange
        case .accommodation:
            return Color.cyan
        case .activity:
            return Color.brandPrimary
        }
    }
}
