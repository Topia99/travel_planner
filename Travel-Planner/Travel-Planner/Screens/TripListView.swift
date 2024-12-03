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
    @State private var isEditing: Bool = false
    @State private var showDeleteConfirmation = false
    @State private var tripToDelete: TripEntity?

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(vm.trips) { trip in
                        if isEditing {
                            // Deletable trip row
                            HStack {
                                Button(action: {
                                    tripToDelete = trip
                                    showDeleteConfirmation = true
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                        .font(.title2)
                                }
                                .padding(.trailing, 8)

                                TripCardView(trip: trip)
                            }
                            .animation(.default, value: vm.trips)
                            .alert("Delete Trip", isPresented: $showDeleteConfirmation, presenting: tripToDelete) { trip in
                                Button("Delete", role: .destructive) {
                                    vm.deleteTrip(trip: trip)
                                }
                                Button("Cancel", role: .cancel) { }
                            } message: { trip in
                                Text("Are you sure you want to delete '\(trip.title ?? "this trip")'?")
                            }
                        } else {
                            NavigationLink(destination: TripView(vm: DayPlanViewModel(trip: trip))) {
                                TripCardView(trip: trip)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
            }
            .navigationTitle(isEditing ? "Delete Trips" : "Trips")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isEditing {
                        Button("Done") {
                            withAnimation {
                                isEditing = false
                            }
                        }
                    } else {
                        Menu {
                            Button(action: {
                                showAddTrip.toggle()
                            }) {
                                Label("Add Trip", systemImage: "plus")
                            }
                            Button(action: {
                                withAnimation {
                                    isEditing = true
                                }
                            }) {
                                Label("Delete Trip", systemImage: "minus.circle")
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
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
