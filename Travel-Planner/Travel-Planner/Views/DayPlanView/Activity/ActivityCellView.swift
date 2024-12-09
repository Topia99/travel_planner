//
//  ItemFoodCellView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/2/24.
//

import SwiftUI

struct ActivityCellView: View {
    @ObservedObject var activity: ActivityEntity

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // Existing Activity Icon
                ItemIconView(
                    imageName: activity.type.iconName,
                    color: activity.type.iconColor
                )

                // Activity Title
                Text(activity.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.leading, 3)
                    .foregroundColor(Color.middleGreen)

                Spacer()

                // Time
                if let time = activity.time {
                    Text(time, style: .time)
                        .font(.headline)
                        .foregroundColor(.black)
                }

                 //Images Icon
                if let imageNames = activity.imageNames, !imageNames.isEmpty {
                    Image(systemName: "photo.on.rectangle")
                        .foregroundColor(Color.middleGreen)
                        .font(.title2)
                        .padding(.leading, 5)
                    
                }
                        
            
            }

            // Existing VStack for Location and Notes
            VStack(alignment: .leading) {
                if let location = activity.location, !location.isEmpty {
                    Text("📍 \(location)")
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.black)
                }

                if let notes = activity.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 2)
                        .foregroundColor(.black)
                }
            }
        }
        .padding(10)
        .frame(width: 350)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 10)
        )
        
    }
}

struct ItemIconView: View {
    let imageName: String
    let color: Color

    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .symbolRenderingMode(.palette)
            .foregroundStyle(.white, color)
            .frame(width: 30, height: 30)
    }
}
