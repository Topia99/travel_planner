//
//  Trip.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/3/24.
//

import Foundation


struct Trip: Identifiable, Codable {
    var id = UUID()
    var title: String
    var startDate: Date
    var endDate: Date
    var destinations: [String]
    var dayPlans: [DayPlan]
    var imageName: String
}



