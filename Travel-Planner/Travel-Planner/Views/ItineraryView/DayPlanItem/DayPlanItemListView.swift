//
//  ItemListView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//

import SwiftUI

struct DayPlanItemListView: View {
    
    @Binding var items: [Item]
    var onItemTap: (Item) -> Void
    
    var body: some View {
        HStack{
            VerticalLine()
            VStack{
                ForEach(items) { item in
                    NavigationLink(destination: ActivityDetailView(item: item )) {
                        ItemCellView(item: item)
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

