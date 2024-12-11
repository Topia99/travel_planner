////
////  TripListView.swift
////  Travel-Planner
////
////  Created by Jason Zeng on 10/10/24.
////
//
//import SwiftUI
//
//struct TripListView: View {
//    @StateObject var vm = TripViewModel()
//    @State private var showAddTrip: Bool = false
//
//    var body: some View {
//        NavigationStack {
//            List {
//                ForEach(vm.trips, id: \.self) { trip in
//                    ZStack(alignment: .leading) {
//                        // Apply horizontal padding to create space on both sides
//                        TripCardView(trip: trip)
//                            .padding(.vertical, 5)
//                            .padding(.horizontal)
//                            .frame(maxWidth: .infinity)
//                        
//                        // Transparent NavigationLink to remove default arrow
//                        NavigationLink(destination: TripView(vm: DayPlanViewModel(trip: trip))) {
//                            EmptyView()
//                        }
//                        .opacity(0) // Make the link transparent
//                    }
//                    .listRowSeparator(.hidden)
//                    .listRowBackground(Color.clear)
//                    .listRowInsets(EdgeInsets())
//                }
//                .onDelete { indices in
//                    for index in indices {
//                        let trip = vm.trips[index]
//                        vm.deleteTrip(trip: trip)
//                    }
//                }
//            }
//            .onAppear() {
//                vm.getTrips()
//            }
//            .listStyle(.plain)
//            .scrollContentBackground(.hidden)
//            .navigationTitle("Trips")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                   
//                    Button {
//                        showAddTrip.toggle()
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                }
//            }
//            .fullScreenCover(isPresented: $showAddTrip) {
//                NavigationStack {
//                    AddTripView(vm: vm)
//                }
//            }
//            .background()
//        }
//    }
//}
//
//#Preview {
//    TripListView()
//}
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
            ZStack {
                // Gradient background
                LinearGradient(
                    gradient: Gradient(colors: [Color.gray.opacity(0.8),
                                                Color.blue.opacity(0.7),
                                                Color.green.opacity(0.7)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                List {
                    ForEach(vm.trips, id: \.self) { trip in
                        ZStack(alignment: .leading) {
                            // Apply horizontal padding to create space on both sides
                            TripCardView(trip: trip)
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                                .frame(maxWidth: .infinity)
                            
                            // Transparent NavigationLink to remove default arrow
                            NavigationLink(destination: TripView(vm: DayPlanViewModel(trip: trip))) {
                                EmptyView()
                            }
                            .opacity(0) // Make the link transparent
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                    }
                    .onDelete { indices in
                        for index in indices {
                            let trip = vm.trips[index]
                            vm.deleteTrip(trip: trip)
                        }
                    }
                }
                .onAppear() {
                    vm.getTrips()
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Trips")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddTrip.toggle()
                    } label: {
                        Image(systemName: "plus")
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
