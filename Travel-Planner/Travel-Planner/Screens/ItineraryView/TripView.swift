//
//  ContentView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import SwiftUI
import Foundation



struct TripView: View {
    
    @EnvironmentObject var tripViewModel: TripViewModel
    @State private var selectedTripIndex: Int = 0
    
    @State private var isShowingAddItem: Bool = false
    @State private var dayPlanIndexToAdd: Int?
    
    
    var body: some View {
        
        
        
        let dayPlans = $tripViewModel.trips[selectedTripIndex].dayPlans
        
        ScrollView {
            LazyVStack {
                ForEach(dayPlans.indices, id: \.self) { index in
                    let dayPlanBinding = dayPlans[index]
                    DayPlanView(dayPlanViewModel: DayPlanViewModel(dayPlan: dayPlanBinding))
                    
                }
            }
        }
        .navigationTitle("Trip Itinerary")
    }
    
    
//    var body: some View {
//        
//        ZStack{
//            
//            NavigationView{
//                VStack{
//                    
//                    HScrollDatesView(dayPlans: $viewModel.dayPlans,
//                                     selectedDate: $viewModel.selectedDates)
//                    HorizontalLine()
//      
//                    
//                    ZStack {
//                        // DayPlan List
//                        ScrollView (.vertical) {
//                            
//                            LazyVStack {
//                                
//                                
//                                ForEach(viewModel.dayPlans.indices, id: \.self) { index in
//                                    
//                                    
//                                    VStack {
//                                        
//                                        DayPlanHeadingView(date: viewModel.dayPlans[index].date, dayNumber: viewModel.dayPlans[index].dayNumber)
//                                        
//                                        
//                                        HStack{
//                                            Text("Day \(viewModel.dayPlans[index].dayNumber):")
//                                            TextField("Day Title", text: $viewModel.dayPlans[index].title, axis: .vertical)
//                                            
//                                            Spacer()
//                                        }
//                                        .font(.title2)
//                                        .fontWeight(.semibold)
//                                        
//                                        
//                                        TextField("Day Description", text: $viewModel.dayPlans[index].description, axis: .vertical)
//                                            .font(.body)
//                                            .padding(.top, 3)
//                                        
//                                        
//                                        
//                                        
//                                        DayPlanItemListView(items: $viewModel.dayPlans[index].items)
//                                        
//                                    }
//                                    
//                                    
//                                    Button {
//                                        dayPlanIndexToAdd = index
//                                        isShowingAddItem.toggle()
//                                    } label: {
//                                        AddItemButton()
//                                    }
//                                    
//                                }
//                                
//                            }
//                        }
//                        
//                        Spacer()
//                    }
//                    
//                }
//                .padding()
//                .background(Color(red: 0.98, green: 0.98, blue: 0.98))
//                .navigationTitle("🏝️ Itinerary")
//
//            }
//            .blur(radius: isShowingAddItem ? 10 : 0)
//            // End of Navigation View
//            
//            
//            
//            
//            if isShowingAddItem {
//                
//                Color.black.opacity(0.4)
//                    .edgesIgnoringSafeArea(.all)
//                    .onTapGesture {
//                        isShowingAddItem.toggle()
//                    }
//                if let dayPlanIndex = dayPlanIndexToAdd {
//                    AddTripItemView(dayPlans: $viewModel.dayPlans, isShowingAddItem: $isShowingAddItem, index: dayPlanIndex)
//                }
//            }
//            
//        } // End of ZStack
//        .animation(.easeInOut, value: isShowingAddItem)
//    }
}


#Preview {
    TripView()
}



struct AddItemButton: View {
    
    var body: some View {
    
        Text("Add Activity")
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 300, height: 50)
            .background(Color.brandPrimary)
            .foregroundColor(.white)
            .cornerRadius(10.0)
    }
}
