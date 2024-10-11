//
//  DayPlan.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/3/24.
//

import Foundation

struct DayPlan: Identifiable, Codable {
    var id = UUID()
    var title: String = ""
    var description: String = ""
    var dayNumber: Int
    var date: Date
    var items: [Item]
}

enum ItemType: String, CaseIterable, Codable {
    case food
    case accommodation
    case activity
}


struct Item: Identifiable, Codable{
    var id = UUID()
    var title: String
    var time: Date?
    var description: String?
    var location: String?
    
    var type: ItemType
}

