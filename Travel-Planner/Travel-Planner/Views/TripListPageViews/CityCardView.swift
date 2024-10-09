//
//  CityCardView.swift
//  Travel-Planner
//
//  Created by siye yang on 10/3/24.

import SwiftUI

struct CityCardView: View {
    var cityName: String
    var countryName: String
    var imageName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) { // Align content to the leading edge
            // City name and country name
            Text(cityName)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            Text(countryName)
                .font(.subheadline)
                .foregroundColor(.white)
            Spacer()
            // Edit button
            Button{
                //action
            }label: {
                Text("Edit")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 7)
                    .background(Color.init(red: 0, green: 0.3843, blue: 0.255))
                    .cornerRadius(10)
            }
        }
        .padding(.leading, 15) // Add padding to the leading edge
        .padding(.vertical, 15)
        .frame(maxWidth: .infinity, alignment: .leading) // Full width and align left
        .frame(height: 150) // Adjusted height
        .background( // Add the image as a background
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity) // Full width
                .frame(height: 150) // Same height as the card
                .clipped() // Ensure the image is clipped to the bounds
                .overlay( // Add a dark overlay on top of the image to improve text readability
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.black.opacity(0.3))
                )
        )
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}




#Preview {
    CityCardView(cityName: "Madrid", countryName: "Spain", imageName: "madrid")
}
