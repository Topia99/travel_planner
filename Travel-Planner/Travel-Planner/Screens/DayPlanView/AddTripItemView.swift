//
//  AddTripItemView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//

import SwiftUI

struct AddTripItemView: View {
    @State var title: String = ""
    @State var time = Date()
    @State var location: String = ""
    @State var description: String = ""

    
//    @Binding var dayPlans: [DayPlan]
//    @Binding var isShowingAddItem: Bool
//    
//    let index: Int
    
    @ObservedObject var viewModel: DayPlanViewModel
    
    
    var body: some View {
        VStack (alignment: .leading){
            HStack() {
                
//                // Activity Symbol
//                switch item.type {
//                case .food:
//                    ItemIconView(imageName: "fork.knife.circle.fill",
//                                 color: Color.orange)
//
//                case .accommodation:
//                    ItemIconView(imageName: "house.circle.fill",
//                                 color: Color.cyan)
//                case .activity:
//                    ItemIconView(imageName: "flag.checkered.circle.fill",
//                                 color: Color.brandPrimary)
//                }
                
                ItemIconView(imageName: "fork.knife.circle.fill",
                             color: Color.orange)
                
                // Activity Title
                TextField("Title", text: $title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.leading, 3)
                
                Spacer()
                
               
                DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
            }
            
            
            HStack {
                Text("📍")
                TextField("location", text: $location)
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            
            
            
            TextField("decription", text: $description)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 2)
            
            
            Button {
                let item = Item(title: title, description: description, location: location, type: .food)
                viewModel.addItem(item)
                viewModel.isShowingAddItem.toggle()
                
//                dayPlans[index].items.append(Item(title: title, description: description, location: location, type: .food))
//                isShowingAddItem.toggle()
            } label: {
                Text("add Item")
            }
            
        }
        .padding()
        .frame(width: 350)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(radius: 2)
        )
    }
}


