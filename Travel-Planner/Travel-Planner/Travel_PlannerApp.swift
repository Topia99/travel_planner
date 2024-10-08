//
//  Travel_PlannerApp.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import SwiftUI

@main
struct Travel_PlannerApp: App {
//    @StateObject private var itineraryViewModel = ItineraryViewModel()
    
    var body: some Scene {
        WindowGroup {
            TravelPlannerView()
//                .environmentObject(itineraryViewModel)
        }
    }
}
