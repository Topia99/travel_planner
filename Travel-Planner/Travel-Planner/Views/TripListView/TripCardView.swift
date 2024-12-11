//
//  TripCardView.swift
//  Travel-Planner
//
//  Created by siye yang on 10/14/24.
//
//
import SwiftUI

struct TripCardView: View {
    var trip: TripEntity
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            // Background image
            Image(trip.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 150)
                .clipped()
                .cornerRadius(15)
            
            
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.6), Color.clear]),
                startPoint: .top,
                endPoint: .bottom
            )
            .cornerRadius(15)
            .frame(height: 150)
            
            // Trip Title
            VStack(alignment: .leading, spacing: 10) {
                Text(trip.title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 20)
                    .padding(.leading, 20)
                Spacer()
            }
            .frame(height: 150)
        }
        .frame(height: 150)
        .cornerRadius(15)
        .shadow(radius: 5)
        
    }
}

