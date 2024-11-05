//
//  TripListView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/10/24.
//

import SwiftUI

struct TripListView: View {
    @EnvironmentObject var tripListViewModel: TripListViewModel
    @State private var showAddTrip: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack {
                    ForEach(tripListViewModel.trips) { tripViewModel in
                        NavigationLink(destination: TripView(tripViewModel: tripViewModel)) {
                            Text(tripViewModel.trip.title)
                        }
                    }
                }
                .navigationTitle("Trips")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAddTrip.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $showAddTrip) {
                NavigationStack {
                    AddTripView()
                }
            }
        }
    }
}

#Preview {
    TripListView()
}
