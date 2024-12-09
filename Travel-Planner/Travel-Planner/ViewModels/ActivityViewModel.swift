//
//  ActivityViewModel.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/18/24.
//

import Foundation
import CoreData
import UIKit

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

    func addActivity(title: String, location: String, time: Date?, notes: String, activityType: ActivityType, images: [UIImage]) {
        let newActivity = ActivityEntity(context: manager.context)
        newActivity.title = title
        newActivity.location = location
        newActivity.time = time
        newActivity.notes = notes
        newActivity.type = activityType
        newActivity.createdAt = Date()
        newActivity.dayPlan = self.dayPlan
        newActivity.trip = self.dayPlan.trip

        // Save images and store filenames
        var imageNames: [String] = []
        for image in images {
            let imageName = UUID().uuidString
            let success = ImageFileManager.instance.saveImage(image: image, name: imageName)
            if success {
                imageNames.append(imageName)
            }
        }
        newActivity.imageNames = imageNames

        save()
    }

    func updateActivity(to activity: ActivityEntity, title: String, location: String, time: Date?, notes: String, type: ActivityType, images: [UIImage]) {
        activity.title = title
        activity.location = location
        activity.time = time
        activity.notes = notes
        activity.type = type

        // Delete old images
        if let oldImageNames = activity.imageNames {
            for name in oldImageNames {
                ImageFileManager.instance.deleteImage(name: name)
            }
        }

        // Save new images and update filenames
        var imageNames: [String] = []
        for image in images {
            let imageName = UUID().uuidString
            let success = ImageFileManager.instance.saveImage(image: image, name: imageName)
            if success {
                imageNames.append(imageName)
            }
        }
        activity.imageNames = imageNames

        save()
    }

    func deleteActivity(_ activity: ActivityEntity) {
        // Delete associated images
        if let imageNames = activity.imageNames {
            for name in imageNames {
                ImageFileManager.instance.deleteImage(name: name)
            }
        }
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

