//
//  AddActivityView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/19/24.
//

import SwiftUI

struct AddActivityView: View {
    
    @ObservedObject var vm: ActivityViewModel
    @Environment(\.dismiss) var dismiss
    
    @State var titleTextField: String = ""
    @State var locationTextField: String = ""
    @State private var selectedActivityType: ActivityType = .activity
    @State var time: Date = Date()
    @State var notesTextField: String = ""
    
    @State var isSetTimeEnabled: Bool = false
    
    // Newly selected images (not saved until user taps "Add")
    @State var selectedImages: [UIImage] = []
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $titleTextField)
                TextField("Location", text: $locationTextField)
            }
            
            Section {
                ActivityTypePickerView(selectedActivityType: $selectedActivityType)
            }
            
            Section {
                Toggle("Set Time", isOn: $isSetTimeEnabled)
                
                if isSetTimeEnabled {
                    DatePicker(
                        "Start time",
                        selection: $time,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                }
            }
            
            Section {
                TextField("Notes", text: $notesTextField, axis: .vertical)
            }
            
            Section(header: Text("Photos")) {
                // "Select Photos" button above image area
                PhotoSelectionView(uiImages: $selectedImages)
                
                // Only show scroll view if there are selected images
                if !selectedImages.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(Array(selectedImages.enumerated()), id: \.offset) { index, uiImage in
                                ZStack(alignment: .topTrailing) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                        .clipped()
                                    
                                    Button(action: {
                                        selectedImages.remove(at: index)
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.red)
                                            .background(Color.white.clipShape(Circle()))
                                    }
                                    .padding(5)
                                }
                            }
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 5)
                    }
                    .frame(height: 120)
                } else {
                    // If no images, show nothing or a minimal spacer
                    Spacer(minLength: 0)
                }
            }
        }
        .navigationTitle("Add Activity")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Cancel Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(.red)
            }
            
            // Add Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add") {
                    let imageDataArray = selectedImages.compactMap { $0.jpegData(compressionQuality: 0.8) }
                    vm.addActivity(
                        title: titleTextField,
                        location: locationTextField,
                        time: isSetTimeEnabled ? time : nil,
                        notes: notesTextField,
                        activityType: selectedActivityType,
                        images: imageDataArray
                    )
                    dismiss()
                }
                .fontWeight(.bold)
                .foregroundColor(titleTextField.isEmpty ? .gray : .red)
                .disabled(titleTextField.isEmpty)
            }
        }
        .onAppear {
            time = vm.dayPlan.date
        }
    }
}


struct ActivityTypePickerView: View {
    @Binding var selectedActivityType: ActivityType

    var body: some View {
        Picker("Type", selection: $selectedActivityType) {
            ForEach(ActivityType.allCases, id: \.self) { type in
                HStack {
                    Label {
                        Text(type.displayName)
                    } icon: {
                        Image(systemName: type.iconName)
                            .renderingMode(.template)
                            .foregroundColor(.gray)
                    }
                }
                .tag(type)
            }
        }
    }
}
