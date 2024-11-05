//
//  ItemListView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//

import SwiftUI

struct DayPlanItemListView: View {
    
    @ObservedObject var dayPlanViewModel: DayPlanViewModel
//    var onItemTap: (Item) -> Void
    
    var body: some View {
        HStack{
            VerticalLine()
            VStack{
                ForEach(dayPlanViewModel.items) { itemViewModel in
                    NavigationLink(destination: ActivityDetailView(itemViewModel: itemViewModel, onDeleted: {dayPlanViewModel.deleteItem(item: itemViewModel)})) {
                        ItemCellView(item: itemViewModel.item)
                    }
                    .buttonStyle(PlainButtonStyle()) // Keeps the original Appearance of ItemCellView
                    
                    
//                    ItemCellView(item: item)
//                        .onTapGesture {
//                            ActivityDetailView(item: item)
//                        }
                }
            }
        }
    }
}

