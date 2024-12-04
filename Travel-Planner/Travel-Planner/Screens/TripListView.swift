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
    @State private var deleteMode: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(vm.trips, id: \.self) { trip in
                        TripListItemView(
                            trip: trip,
                            deleteMode: $deleteMode,
                            deleteAction: deleteTrip)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
            }
            .navigationTitle(deleteMode ? "Delete Trips" : "Trips")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if deleteMode {
                        // Show "Done" button to exit delete mode
                        Button("Done") {
                            deleteMode = false
                        }
                        .foregroundColor(.blue)
                    } else {
                        // Show a menu with "Add" and "Delete" options
                        Menu {
                            Button(action: {
                                showAddTrip.toggle()
                            }) {
                                Label("Add", systemImage: "plus")
                            }
                            Button(action: {
                                deleteMode.toggle()
                            }) {
                                Label("Delete", systemImage: "trash")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
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

    private func deleteTrip(_ trip: TripEntity) {
        vm.deleteTrip(trip: trip)
    }
}

struct TripListItemView: View {
    var trip: TripEntity
    @Binding var deleteMode: Bool
    var deleteAction: (TripEntity) -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            NavigationLink(destination: TripView(vm: DayPlanViewModel(trip: trip))) {
                TripCardView(trip: trip)
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(deleteMode)

            if deleteMode {
                Button(action: {
                    deleteAction(trip)
                }) {
                    Image(systemName: "minus.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                }
                .padding([.top, .trailing], 10)
            }
        }
    }
}


#Preview {
    TripListView()
}
