//
//  DayPlanViewModel.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//

import SwiftUI

class DayPlanViewModel: ObservableObject {
    @Binding var dayPlan: DayPlan
    @Published var isShowingAddItem: Bool = false
    
    init(dayPlan: Binding<DayPlan>){
        self._dayPlan = dayPlan
    }
    
    func addItem(_ item: Item) {
        dayPlan.items.append(item)
    }
    
}
