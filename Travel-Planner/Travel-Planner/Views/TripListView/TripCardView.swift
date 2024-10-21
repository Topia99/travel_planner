//
//  TripCardView.swift
//  Travel-Planner
//
//  Created by siye yang on 10/14/24.
//

import SwiftUI

struct TripCardView: View {
    var trip: Trip

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background image
            Image(trip.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipped()
                .cornerRadius(15)

            // Overlay with gradient for better text readability
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                startPoint: .top,
                endPoint: .bottom
            )
            .cornerRadius(15)
            .frame(height: 150)

            // Trip Title
            VStack(alignment: .leading) {
                Text(trip.title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 15)
                    .padding(.leading, 15)
                Spacer()
            }
            .frame(height: 150)
        }
        .frame(height: 150)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.vertical, 5)
    }
}



#Preview {
    TripCardView(
        trip: Trip(
            title: "Sample Trip",
            startDate: Date(),
            endDate: Date(),
            destinations: ["Sample Destination"],
            dayPlans: [],
            imageName: defaultTripImages.randomElement() ?? "defaultImage"
        )
    )
}
