//
//  DayPlanView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//

import SwiftUI

struct DayPlanView: View {
    
    @Binding var dayPlan: DayPlan
    @State var isShowingAddItem: Bool = false
    
    var body: some View {
        ScrollView{
            VStack {
                // DayPlan Date Heading View
                DayPlanHeadingView(date: dayPlan.date, dayNumber: dayPlan.dayNumber)
                
                // dayPlan title and description
                HStack{
                    Text("Day \(dayPlan.dayNumber):")
                    TextField("Day Title", text: $dayPlan.title, axis: .vertical)
                    
                    Spacer()
                }
                .font(.title2)
                .fontWeight(.semibold)
                
                
                TextField("Day Description", text: $dayPlan.description, axis: .vertical)
                    .font(.body)
                    .padding(.top, 3)
                
                
                
                // Item List
                DayPlanItemListView(items: $dayPlan.items)
                
                Button {
                    isShowingAddItem.toggle()
                } label: {
                    AddItemButton()
                }
                
            }
            .padding()
            .sheet(isPresented: $isShowingAddItem) {
                AddTripItemView(items: $dayPlan.items, isShowingAddItem: $isShowingAddItem)
            }
        }
    }
}

#Preview {
    DayPlanView(dayPlan: .constant(DayPlan(dayNumber: 1, date: Date(), items: MockData.mockItems)))
}
