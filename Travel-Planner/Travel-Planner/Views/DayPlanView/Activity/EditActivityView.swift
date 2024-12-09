//
//  EditActivityView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 11/20/24.
//


import SwiftUI
import PhotosUI

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

    // Photo selection properties
    @State private var selectedPhotos: [UIImage] = []
    @State private var showImagePicker: Bool = false
    @State private var photoPickerItems: [PhotosPickerItem] = []

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
                // Add Photos Button
                Button(action: {
                    showImagePicker = true
                }) {
                    Text("Add Photos")
                }

                // Display Existing Photos with Delete Buttons
                if let imageNames = activity.imageNames, !imageNames.isEmpty {
                    VStack(alignment: .center, spacing: 16) {
                        ForEach(imageNames, id: \.self) { name in
                            ZStack(alignment: .topTrailing) {
                                if let image = ImageFileManager.instance.getImage(name: name) {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: .infinity, maxHeight: 300)
                                        .cornerRadius(8)
                                        .shadow(radius: 4)
                                        .padding(.horizontal)
                                }

                                // Delete Button
                                Button(action: {
                                    deleteImage(named: name)
                                }) {
                                    Image(systemName: "trash.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title)
                                        .padding()
                                }
                                .accessibilityLabel("Delete photo")
                            }
                        }
                    }
                } else {
                    Text("No photos available.")
                        .foregroundColor(.secondary)
                }

                // Display Newly Selected Photos
                if !selectedPhotos.isEmpty {
                    VStack(alignment: .center, spacing: 16) {
                        ForEach(selectedPhotos, id: \.self) { image in
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: 300)
                                    .cornerRadius(8)
                                    .shadow(radius: 4)
                                    .padding(.horizontal)

                                // Delete Button for Newly Selected Photos
                                Button(action: {
                                    if let index = selectedPhotos.firstIndex(of: image) {
                                        selectedPhotos.remove(at: index)
                                    }
                                }) {
                                    Image(systemName: "trash.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title)
                                        .padding()
                                }
                                .accessibilityLabel("Remove photo")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Edit Activity")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Cancel Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundStyle(Color.middleGreen)
            }

            // Save Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    let allImages = getAllImages()
                    vm.updateActivity(
                        to: activity,
                        title: titleTextField,
                        location: locationTextField,
                        time: isSetTime ? time : nil,
                        notes: notesTextField,
                        type: selectedActivityType,
                        images: allImages
                    )
                    dismiss()
                }
                .fontWeight(.bold)
                .foregroundStyle(Color.middleGreen)
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

    private func getAllImages() -> [UIImage] {
        var images: [UIImage] = []

        // Existing images that have not been deleted
        if let imageNames = activity.imageNames {
            for name in imageNames {
                if let image = ImageFileManager.instance.getImage(name: name) {
                    images.append(image)
                }
            }
        }

        // Newly selected images
        images.append(contentsOf: selectedPhotos)

        return images
    }

    private func deleteImage(named imageName: String) {
        // Remove image name from activity's imageNames
        if var imageNames = activity.imageNames {
            imageNames.removeAll { $0 == imageName }
            activity.imageNames = imageNames.isEmpty ? nil : imageNames
        }

        // Delete image from file system
        ImageFileManager.instance.deleteImage(name: imageName)

        // Save changes to Core Data
        vm.save()
    }
}
