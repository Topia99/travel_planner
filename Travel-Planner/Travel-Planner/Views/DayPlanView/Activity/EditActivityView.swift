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

    // A local copy of the existing images from the activity
    @State var currentImagesData: [Data] = []
    
    // Newly selected images (not saved yet)
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
                Toggle("Set Time", isOn: $isSetTime)
                if isSetTime {
                    DatePicker("Start time", selection: $time, displayedComponents: [.date, .hourAndMinute])
                }
            }

            Section {
                TextField("Notes", text: $notesTextField, axis: .vertical)
            }

            Section(header: Text("Photos")) {
                // "Select Photos" button above image area
                PhotoSelectionView(uiImages: $selectedImages)

                // Only show the scroll view if there's at least one image
                if !currentImagesData.isEmpty || !selectedImages.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            // Existing images
                            ForEach(Array(currentImagesData.enumerated()), id: \.offset) { index, data in
                                if let uiImage = UIImage(data: data) {
                                    ZStack(alignment: .topTrailing) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(10)
                                            .clipped()
                                        
                                        Button(action: {
                                            // Remove image from currentImagesData
                                            currentImagesData.remove(at: index)
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.red)
                                                .background(Color.white.clipShape(Circle()))
                                        }
                                        .padding(5)
                                    }
                                }
                            }
                            
                            // Newly selected images
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
                    // If no images, no scroll view is shown.
                    // Just a spacer or leave empty.
                    Spacer(minLength: 0)
                }
            }
        }
        .navigationTitle("Edit Activity")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    // Discard changes by not saving them to activity.images
                    dismiss()
                }
                .foregroundStyle(.red)
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    // Combine existing and newly selected images on "Done"
                    let newImagesData = selectedImages.compactMap { $0.jpegData(compressionQuality: 0.8) }
                    let finalImages = currentImagesData + newImagesData

                    vm.updateActivity(
                        to: activity,
                        title: titleTextField,
                        location: locationTextField,
                        time: isSetTime ? time : nil,
                        notes: notesTextField,
                        type: selectedActivityType,
                        images: finalImages
                    )
                    
                    dismiss()
                }
                .disabled(titleTextField.isEmpty)
                .fontWeight(.bold)
                .foregroundColor(titleTextField.isEmpty ? .gray : Color.middleGreen)
            }
        }
        .onAppear {
            self.titleTextField = activity.title
            self.locationTextField = activity.location ?? ""
            self.selectedActivityType = activity.type
            self.time = activity.time ?? Date()
            self.notesTextField = activity.notes ?? ""
            isSetTime = activity.time != nil

            // Load existing images into currentImagesData
            self.currentImagesData = activity.images ?? []
        }
    }
}
