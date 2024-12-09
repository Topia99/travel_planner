//
//  TripListView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/10/24.
//

import SwiftUI

struct TripListView: View {
    @StateObject var vm = TripViewModel()
    @State private var showAddTrip: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack {
                    ForEach(vm.trips) { trip in
                        NavigationLink(destination: TripView(vm: DayPlanViewModel(trip: trip))) {
                            Text(trip.title)
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
            .onAppear() {
                // getTrips on Apear
                vm.getTrips()
            }
            .fullScreenCover(isPresented: $showAddTrip) {
                NavigationStack {
                    AddTripView(vm: vm)
                }
            }
        }
    }
}

#Preview {
    TripListView()
}
