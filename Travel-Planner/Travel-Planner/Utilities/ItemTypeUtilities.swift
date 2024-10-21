//
//  ItemTypeUtilities.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/10/24.
//

import SwiftUI

struct ItemTypeUtilities {
    static func iconName(for itemType: ItemType) -> String {
        switch itemType{
        case .food:
            return "fork.knife.circle.fill"
        case .accommodation:
            return "house.circle.fill"
        case .activity:
            return "flag.checkered.circle.fill"
        }
    }
    
    static func iconColor(for itemType: ItemType) -> Color {
        switch itemType {
        case .food:
            return Color.orange
        case .accommodation:
            return Color.cyan
        case .activity:
            return Color.brandPrimary
        }
    }
    
    static func itemTypeDisplayName(for itemType: ItemType) -> String {
        switch itemType {
        case .food:
            return "Food"
        case .accommodation:
            return "Accommodation"
        case .activity:
            return "Activity"
        }
    }
}
