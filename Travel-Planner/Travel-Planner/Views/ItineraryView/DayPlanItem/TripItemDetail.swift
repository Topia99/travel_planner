//
//  AddTripItemView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//
import SwiftUI

struct TripItemDetail: View {
    @Environment(\.dismiss) var dismiss

    @State private var title: String = ""
    @State private var location: String = ""
    @State private var time: Date = Date()
    @State private var description: String = ""
    @State private var selectedItemType: ItemType = .activity
    @State private var isTimePickerPresented: Bool = false

    var itemToEdit: Item?       // Optional item to edit
    var onSave: (Item) -> Void  // Closure to handle saving the item

    var body: some View {
        VStack(spacing: 0) {
            // Title TextField
            TitleInputView(title: $title)

            Divider()

            List {
                // Item Type Picker
                ItemTypePickerView(selectedItemType: $selectedItemType)

                // Location Input
                LocationInputView(location: $location)

                // Time Input
                TimeInputView(time: $time, isPresented: $isTimePickerPresented)

                // Description Input
                DescriptionInputView(description: $description)
            }
            .listStyle(.plain)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Cancel Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }

            // Save Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    let newItem = Item(
                        id: itemToEdit?.id ?? UUID(), // Use existing id or generate a new one
                        title: title,
                        location: location.isEmpty ? nil : location,
                        time: time,
                        description: description.isEmpty ? nil : description,
                        type: selectedItemType
                    )
                    onSave(newItem)  // Passes newItem back to the parent view via the onSave closure.
                    dismiss()
                }
                .foregroundColor(title.isEmpty ? .gray : ItemTypeUtilities.iconColor(for: selectedItemType))
                .disabled(title.isEmpty) // Do not allow saving without a title
            }
        }
        .foregroundColor(ItemTypeUtilities.iconColor(for: selectedItemType))
        .onAppear {
            // Populate fields if editing an existing item
            if let item = itemToEdit {
                title = item.title
                location = item.location ?? ""
                time = item.time ?? Date()
                description = item.description ?? ""
                selectedItemType = item.type
            }
        }
    }
}



struct TitleInputView: View {
    @Binding var title: String

    var body: some View {
        TextField("Title", text: $title)
            .padding()
            .background(Color(UIColor.systemBackground))
    }
}


/// A view that allows the user to select the type of the item.
/// It presents a picker with all available `ItemType` cases.
struct ItemTypePickerView: View {
    @Binding var selectedItemType: ItemType

    var body: some View {
        Picker("Type", selection: $selectedItemType) {
            ForEach(ItemType.allCases, id: \.self) { itemType in
                HStack {
                    
                    Label {
                        Text(ItemTypeUtilities.itemTypeDisplayName(for: itemType))
                    } icon: {
                        Image(systemName: ItemTypeUtilities.iconName(for: itemType))
                            .foregroundStyle(Color.white, ItemTypeUtilities.iconColor(for: itemType))
                    }
                    
                }
                .tag(itemType)
            }
        }
    }
}

struct LocationInputView: View {
    @Binding var location: String

    var body: some View {
        HStack {
            Image(systemName: "location")
            TextField("Location", text: $location)
        }
    }
}


struct TimeInputView: View {
    @Binding var time: Date
    @Binding var isPresented: Bool // Binding to control the presentation of the time picker

    var body: some View {
        HStack {
            Image(systemName: "clock")
            Spacer()
            Button(action: {
                isPresented = true // Show the time picker
            }) {
                Text(time, style: .time)
                    .foregroundColor(.secondary)
            }
            .sheet(isPresented: $isPresented) {
                VStack {
                    DatePicker("Set Time", selection: $time, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .labelsHidden()
                    Button("Done") {
                        isPresented = false // Dismiss the time picker
                    }
                    .padding()
                }
                .presentationDetents([.medium])
            }
        }
    }
}



struct DescriptionInputView: View {
    @Binding var description: String

    var body: some View {
        TextField("Description...", text: $description, axis: .vertical)
            .foregroundStyle(.secondary)
    }
}
