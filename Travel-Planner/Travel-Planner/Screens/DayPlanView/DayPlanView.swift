//
//  DayPlanView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//

import SwiftUI

struct DayPlanView: View {
    
//    @Binding var dayPlan: DayPlan
    @StateObject var dayPlanViewModel: DayPlanViewModel
    
    var body: some View {
        
        ZStack {
            VStack {
                // DayPlan Date Heading View
                DayPlanHeadingView(date: dayPlanViewModel.dayPlan.date, dayNumber: dayPlanViewModel.dayPlan.dayNumber)
                
                
                HStack{
                    Text("Day \(dayPlanViewModel.dayPlan.dayNumber):")
                    TextField("Day Title", text: $dayPlanViewModel.dayPlan.title, axis: .vertical)
                    
                    Spacer()
                }
                .font(.title2)
                .fontWeight(.semibold)
                
                
                TextField("Day Description", text: $dayPlanViewModel.dayPlan.description, axis: .vertical)
                    .font(.body)
                    .padding(.top, 3)
                
                
                
                
                DayPlanItemListView(items: $dayPlanViewModel.dayPlan.items)
                
                Button {
                    dayPlanViewModel.isShowingAddItem.toggle()
                } label: {
                    AddItemButton()
                }
                
            }
            
            if dayPlanViewModel.isShowingAddItem {
                
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        dayPlanViewModel.isShowingAddItem.toggle()
                    }
                AddTripItemView(viewModel: dayPlanViewModel)
            }
        }
    }
}

#Preview {
  
}
