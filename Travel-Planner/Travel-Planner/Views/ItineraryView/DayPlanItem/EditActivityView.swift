//
//  EditActivityView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/20/24.
//

import SwiftUI

struct EditActivityView: View {
    
    @ObservedObject var activity: ActivityEntity
    @StateObject var vm: ActivityViewModel
    @Environment(\.dismiss) var dismiss
    
    
    @State var titleTextField: String = ""
    @State var locationTextField: String = ""
    @State var selectedActivityType: ActivityType = .activity
    @State var time: Date = Date()
    @State var notesTextField: String = ""
    
    @State var isSetTime: Bool = false
    
    
    var body: some View {
        Form {
            Section() {
                TextField("Title", text: $titleTextField)
                TextField("Location", text: $locationTextField)
            }
            
            Section() {
                ActivityTypePickerView(selectedActivityType: $selectedActivityType)
            }
            
            Section() {
                Toggle("Set Time", isOn: $isSetTime)
                
                if isSetTime {
                    DatePicker(
                        "Start time",
                        selection: $time,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                }
            }
            
            Section() {
                TextField("Notes", text: $notesTextField, axis: .vertical)
            }
            
            
            
        }
        .navigationTitle("Edit Activity") // Add Activity or Edit Activity
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Cancel Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(.red)
            }
            
            // Add / Done Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    activity.title = titleTextField
                    activity.location = locationTextField
                    activity.type = selectedActivityType
                    activity.time = isSetTime ? time : nil
                    activity.notes = notesTextField
                    
                    vm.save()
                    
                    dismiss()
                }
                .fontWeight(.bold)
                .foregroundStyle(.red)
            }
        }
        .onAppear {
            self.titleTextField = activity.title
            self.locationTextField = activity.location ?? ""
            self.selectedActivityType = activity.type
            self.time = activity.time ?? Date()
            self.notesTextField = activity.notes ?? ""
            
            isSetTime = activity.time != nil
        }
    }
}




