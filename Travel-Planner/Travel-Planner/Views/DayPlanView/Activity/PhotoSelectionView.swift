//
//  PhotoSelectionView.swift
//  Travel-Planner
//
//  Created by siye yang on 12/10/24.
//

import SwiftUI
import PhotosUI

struct PhotoSelectionView: View {
    @Binding var uiImages: [UIImage]
    @State private var photoItems: [PhotosPickerItem] = []

    var body: some View {
        // Only a button to select photos, no preview of selected images here
        PhotosPicker(
            selection: $photoItems,
            maxSelectionCount: 0, // no limit or specify a limit
            matching: .images
        ) {
            Label("Select Photos", systemImage: "photo.on.rectangle.angled")
                .foregroundColor(.blue)
        }
        .onChange(of: photoItems) { oldItem, newItems in
            Task {
                for item in newItems {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let img = UIImage(data: data) {
                        uiImages.append(img)
                    }
                }
                photoItems.removeAll()
            }
        }
    }
}
