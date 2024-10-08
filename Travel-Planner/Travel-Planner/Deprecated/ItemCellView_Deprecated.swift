//
//  ItemCellView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/3/24.
//
//
//import SwiftUI
//
//struct ItemCellView_Deprecated: View {
//    
//    @Binding var item: TripItem
//    
//    @ViewBuilder
//    var body: some View {
//        switch item.type {
//        case .food:
//            if let foodBinding = $item as? Binding<FoodItem> {  // Safely cast the binding
//                ItemFoodCellView(item: foodBinding)
//            }
//        case .accommodation:
//            if let accommodationBinding = $item as? Binding<AccommodationItem> {
//                ItemAccommodationView(item: accommodationBinding)
//            }
//        case .activity:
//            if let activityBinding = $item as? Binding<ActivityItem> {
//                ItemActivityView(item: activityBinding)
//            }
//        }
//    }
//}

