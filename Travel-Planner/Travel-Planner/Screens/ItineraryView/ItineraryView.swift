//
//  ContentView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 9/26/24.
//

import SwiftUI
import Foundation



struct ItineraryView: View {
    
    
//    @EnvironmentObject var viewModel: ItineraryViewModel
    
    @StateObject var viewModel = ItineraryViewModel()
    
    @State private var isShowingAddItem: Bool = false
    @State private var dayPlanIndexToAdd: Int?
    
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case title, description
    }
    
    
    var body: some View {
        
        ZStack{
            
            NavigationView{
                VStack{
                    
                    HScrollDatesView(dayPlans: $viewModel.dayPlans,
                                     selectedDate: $viewModel.selectedDates)
                    HorizontalLine()
      
                    
                    ZStack {
                        // DayPlan List
                        ScrollView (.vertical) {
                            
                            LazyVStack {
                                
                                
                                ForEach(viewModel.dayPlans.indices, id: \.self) { index in
                                    
                                    
                                    VStack {
                                        
                                        DayPlanHeadingView(date: viewModel.dayPlans[index].date, dayNumber: viewModel.dayPlans[index].dayNumber)
                                        
                                        HStack{
                                            Text("Day \(viewModel.dayPlans[index].dayNumber):")
                                            TextField("Day Title", text: $viewModel.dayPlans[index].title, axis: .vertical)
                                                .focused($focusedField, equals: .title)
                                            Spacer()
                                        }
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                
                                        
                                        TextField("Day Description", text: $viewModel.dayPlans[index].description, axis: .vertical)
                                            .font(.body)
                                            .padding(.top, 3)
                                            .focused($focusedField, equals: .description)
                                        
                                        DayPlanItemListView(items: $viewModel.dayPlans[index].items)
                                        
                                    }
                                    
                                    
                                    Button {
                                        dayPlanIndexToAdd = index
                                        isShowingAddItem.toggle()
                                    } label: {
                                        AddItemButton()
                                    }
                                    
                                }
                                
                            }
                        }
                        
                        Spacer()
                    }
                    
                }
                .padding()
                .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                .navigationTitle("🏝️ Itinerary")

            }
            .onTapGesture {
                focusedField = nil
            }
            .blur(radius: isShowingAddItem ? 10 : 0)
            // End of Navigation View
            
            
            if isShowingAddItem {
                
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isShowingAddItem.toggle()
                    }
                if let dayPlanIndex = dayPlanIndexToAdd {
                    AddTripItemView(dayPlans: $viewModel.dayPlans, isShowingAddItem: $isShowingAddItem, index: dayPlanIndex)
                }
            }
            
        } // End of ZStack
        .animation(.easeInOut, value: isShowingAddItem)
    }
}


#Preview {
    ItineraryView()
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
