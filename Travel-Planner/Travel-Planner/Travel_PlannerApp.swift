//
//  Travel_PlannerApp.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import SwiftUI

@main
struct Travel_PlannerApp: App {
    @StateObject var tripViewModel = TripViewModel(trips: MockData.mockTrips)
    
    var body: some Scene {
        WindowGroup {
            TravelPlannerView()
                .environmentObject(tripViewModel)
        }
    }
}
