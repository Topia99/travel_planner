//
//  ItemListView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//

import SwiftUI

struct DayPlanItemListView: View {
    
    @Binding var items: [Item]
    
    var body: some View {
        HStack{
            VerticalLine()
            
            VStack{
                ForEach(items) { item in
                    ItemCellView(item: item)
                }
            }
        }
    }
}

