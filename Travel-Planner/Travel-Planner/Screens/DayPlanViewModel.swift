//
//  DayPlanViewModel.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/3/24.
//

import SwiftUI

final class DayPlanViewModel: ObservableObject, Identifiable {
    @Published var dayPlan: DayPlan
    @Published var items: [ItemViewModel]
    
    init(dayPlan: DayPlan) {
        self.dayPlan = dayPlan
        self.items = dayPlan.items.map { ItemViewModel(item: $0)}
    }
    
    func addItem(title: String, type: ItemType, location: String?, date: Date?, url: String?, notes: String?) {
        let newItem = Item(title: title, location: location, date: date, url: url, notes: notes, type: type)
        let newItemViewModel = ItemViewModel (item: newItem)
        items.append(newItemViewModel)
        dayPlan.items.append(newItem)
    }
    
    func deleteItem(item: ItemViewModel) {
        items.removeAll { $0.id == item.id }
        dayPlan.items.removeAll { $0.id == item.item.id }
    }
}
