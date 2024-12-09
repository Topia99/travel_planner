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
                        DeleteMode(
                            trip: trip,
                            deleteMode: $deleteMode,
                            deleteAction: vm.deleteTrip)
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
}

#Preview {
    TripListView()
}
