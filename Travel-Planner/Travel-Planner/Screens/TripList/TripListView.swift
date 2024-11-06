import SwiftUI

struct TripListView: View {
    @EnvironmentObject var tripViewModel: TripViewModel
    @State private var showAddTrip: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach($tripViewModel.trips) { $trip in
                            NavigationLink(destination: TripView(trip: $trip)) {
                                TripCardView(trip: trip, viewModel: tripViewModel)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
                
                Button(action: {
                    showAddTrip.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add New Trip")
                            .fontWeight(.bold)
                    }
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
            }
            .navigationTitle("Trips")
            .fullScreenCover(isPresented: $showAddTrip) {
                NavigationStack {
                    AddTripView()
                }
            }
        }
    }
}

struct TripCardView: View {
    var trip: Trip
    var viewModel: TripViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(trip.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button(action: {
                    viewModel.deleteTrip(trip)
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
                
                Button(action: {
                    viewModel.exportTrip(trip)
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.blue)
                }
            }
            
            Text("Start Date: \(DateUtilities.formattedDate(trip.startDate))")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("End Date: \(DateUtilities.formattedDate(trip.endDate))")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if !trip.destinations.isEmpty {
                Text("Destinations: \(trip.destinations.joined(separator: ", "))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

#Preview {
    TripListView()
        .environmentObject(TripViewModel())
}
