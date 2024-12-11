//
//  Travel_PlannerApp.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import SwiftUI

@main
struct Travel_PlannerApp: App {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some Scene {
        WindowGroup {
            TripListView()
        }
    }
}
