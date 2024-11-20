//
//  ActivityViewModel.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/18/24.
//

import Foundation
import CoreData

class ActivityViewModel: ObservableObject {
    let manager = CoreDataManager.instance
    let dayPlan: DayPlanEntity
    @Published var activities: [ActivityEntity] = []
    
    init(dayPlan: DayPlanEntity) {
        self.dayPlan = dayPlan
        getActivities()
    }
    
    func getActivities() {
        let request = NSFetchRequest<ActivityEntity>(entityName: "ActivityEntity")
        let filter = NSPredicate(format: "dayPlan == %@", self.dayPlan)
        request.predicate = filter
        
        do {
            activities = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching activities: \(error.localizedDescription)")
        }
    }
    
    func addActivity(title: String, location: String, time: Date?, notes: String, activityType: ActivityType) {
        let newActivity = ActivityEntity(context: manager.context)
        newActivity.title = title
        newActivity.location = location
        newActivity.time = time
        newActivity.notes = notes
        newActivity.type = activityType
        newActivity.createdAt = Date()
        
        newActivity.dayPlan = self.dayPlan
        newActivity.trip = self.dayPlan.trip
        
        save()
    }
    
    func updateActivity(to activity: ActivityEntity, title: String, location: String, time: Date?, notes: String, type: ActivityType) {
        
        activity.title = title
        activity.location = location
        activity.time = time
        activity.notes = notes
        activity.type = type
        
        save()
    }
    
    func deleteActivity(_ activity: ActivityEntity) {
        manager.context.delete(activity)
        save()
    }
    
    func save() {
        activities.removeAll()
        
        DispatchQueue.main.async {
            self.manager.save()
            self.getActivities()
        }
    }
}
