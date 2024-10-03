//
//  CityCardView.swift
//  Travel-Planner
//
//  Created by siye yang on 10/3/24.
//

import SwiftUI

struct CityCardView: View {
    var cityName: String
    var countryName: String
    var imageName: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(imageName)
                            .resizable() // Makes the image resizable
                            .aspectRatio(contentMode: .fill) // Fills the card
                            .frame(height: 150)
                            .cornerRadius(15)
                            .clipped() // Ensures the image fits within the bounds of the card
            
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.black.opacity(0.3))
                .frame(height: 150)
            
            VStack(alignment: .leading) {
                Text(cityName)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                Text(countryName)
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                Spacer()
                
                // Edit button
                Button(action: {}) {
                    Text("Edit")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                .padding(.bottom, 10)
            }
            .padding(.leading, 15)
            .padding(.vertical, 15)
        }
        .shadow(radius: 5)
    }
}


#Preview {
    CityCardView(cityName: "Madrid", countryName: "Spain", imageName: "madrid")
}
