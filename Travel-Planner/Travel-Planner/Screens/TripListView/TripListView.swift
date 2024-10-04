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
                        LazyVStack(spacing: 20) {
                            // Loop through the cities and create a card for each
                            ForEach(cities, id: \.cityName) { city in
                                CityCardView(cityName: city.cityName, countryName: city.countryName, imageName: city.imageName)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                // Add button in the top-right corner
                Button() {
                    //action
                }label: {
                    
                    Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .frame(width: 16, height: 16) // Adjust the size of the plus icon
                            .padding(10) // Adjust the padding to reduce the circle size
                            .background(Color.init(red: 0, green: 0.3843, blue: 0.255))
                            .clipShape(Circle())
                }
                .padding(.trailing, 25)
                .padding(.top, 40)
            }
        }

}


#Preview {
    TripListView()
}
