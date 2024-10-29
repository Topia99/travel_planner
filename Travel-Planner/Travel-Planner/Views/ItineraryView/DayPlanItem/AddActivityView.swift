//
//  AddActivityView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/29/24.
//

import SwiftUI

struct AddActivityView: View {
    
    @State var title: String = ""
    @State var location: String = ""
    @State var selectedItemType: ItemType = .food
    @State var date: Date = Date()
    @State var url: String = ""
    @State var notes: String = ""
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        Form {
            Section() {
                TextField("Title", text: $title)
                TextField("Location", text: $location)
            }
            
            Section() {
                ItemTypePickerView(selectedItemType: $selectedItemType)
            }
            
            Section() {
                    DatePicker(
                        "Start time",
                        selection: $date,
                        displayedComponents: [.date, .hourAndMinute]
                    )
            }
            
            Section() {
                TextField("url", text: $url)
                
                TextField("Notes", text: $notes, axis: .vertical)
                
            }
            
            
            
        }
        .navigationTitle("Add Activity") // Add Activity or Edit Activity
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Cancel Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    print("Cancel")
                }
                .foregroundStyle(.red)
            }
            
            // Add / Done Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") {
                    print("add")
                }
                .fontWeight(.bold)
                .foregroundStyle(.red)
            }
        }
    }
}


#Preview {
    NavigationStack{
        AddActivityView()
    }
}
