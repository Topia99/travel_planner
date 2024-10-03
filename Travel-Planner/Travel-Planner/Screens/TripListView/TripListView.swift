//
//  TripListView.swift
//  Travel-Planner
//
//  Created by siye yang on 10/2/24.
//

import SwiftUI

struct TripListView: View {
    
    let cities = [
            City(cityName: "Madrid", countryName: "Spain", imageName: "madrid"),
            City(cityName: "Paris", countryName: "France", imageName: "paris"),
            City(cityName: "Dubrovnik", countryName: "Croatia", imageName: "dubrovnik")
        ]
    
    var body: some View {
            ZStack(alignment: .topTrailing) {
                // Main content
                VStack(alignment: .leading) {
                    // Title
                    Text("Cities")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 40)
                        .padding(.leading, 20)
                    
                    // ScrollView to hold the cards
                    ScrollView {
                        VStack(spacing: 20) {
                            // Loop through the cities and create a card for each
                            ForEach(cities, id: \.cityName) { city in
                                CityCardView(cityName: city.cityName, countryName: city.countryName, imageName: city.imageName)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                // Add button in the top-right corner
                Button(action: {}) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .clipShape(Circle())
                }
                .padding(.trailing, 20)
                .padding(.top, 35)
            }
        }

}


#Preview {
    TripListView()
}
