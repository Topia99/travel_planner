//
//  AddActivityView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/19/24.
//


import SwiftUI
import PhotosUI

struct AddActivityView: View {
    @ObservedObject var vm: ActivityViewModel
    @Environment(\.dismiss) var dismiss

    @State var titleTextField: String = ""
    @State var locationTextField: String = ""
    @State private var selectedActivityType: ActivityType = .activity
    @State var time: Date = Date()
    @State var notesTextField: String = ""

    @State var isSetTimeEnabled: Bool = false

    // Photo selection properties
    @State private var selectedPhotos: [UIImage] = []
    @State private var showImagePicker: Bool = false
    @State private var photoPickerItems: [PhotosPickerItem] = []

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
                Toggle("Set Time", isOn: $isSetTimeEnabled)

                if isSetTimeEnabled {
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

            Section(header: Text("Photos")) {
                Button(action: {
                    showImagePicker = true
                }) {
                    Text("Add Photos")
                }

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(selectedPhotos, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(8)
                        }
                    }
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
                    vm.addActivity(
                        title: titleTextField,
                        location: locationTextField,
                        time: isSetTimeEnabled ? time : nil,
                        notes: notesTextField,
                        activityType: selectedActivityType,
                        images: selectedPhotos
                    )
                    dismiss()
                    
                }
                .disabled(titleTextField.isEmpty)
                .fontWeight(.bold)
                .foregroundColor(titleTextField.isEmpty ? .gray : Color.middleGreen)
            }
        }
        .photosPicker(isPresented: $showImagePicker, selection: $photoPickerItems, maxSelectionCount: 5)
        .onChange(of: photoPickerItems) {
            loadImages(from: photoPickerItems)
        }
    }

    private func loadImages(from items: [PhotosPickerItem]) {
        for item in items {
            item.loadTransferable(type: Data.self) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data?):
                        if let image = UIImage(data: data) {
                            self.selectedPhotos.append(image)
                        } else {
                            print("Could not convert data to UIImage.")
                        }
                    case .success(nil):
                        print("Data is nil")
                    case .failure(let error):
                        print("Error loading image data: \(error)")
                    }
                }
            }
        }
    }
}
