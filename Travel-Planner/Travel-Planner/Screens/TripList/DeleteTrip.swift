//
//  DeleteTrip.swift
//  Travel-Planner
//
//  Created by Aaron Lee on 11/5/24.
//
import SwiftUI

struct DeleteActivityView: View {
    @Binding var dayPlan: DayPlan
    @EnvironmentObject var tripViewModel: TripViewModel
    
    var body: some View {
        List {
            ForEach(dayPlan.items.indices, id: \.self) { index in
                HStack {
                    Text(dayPlan.items[index].title)
                        .font(.headline)
                    
                    Spacer()
                    
                    Button(action: {
                        deleteActivity(at: IndexSet(integer: index))
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }
                }
            }
            .onDelete(perform: deleteActivity)
        }
        .navigationTitle("Delete Activities")
    }
    
    private func deleteActivity(at indices: IndexSet) {
        indices.forEach { index in
            dayPlan.items.remove(at: index)
        }
        tripViewModel.saveTrips()
    }
}

// Sample preview
struct DeleteActivityView_Previews: PreviewProvider {
    static var previews: some View {
        let dayPlan = DayPlan(dayNumber: 1, date: Date(), items: [
            Item(id: UUID(), title: "Visit Museum", location: "Downtown", time: Date(), description: "Explore local history.", type: .activity),
            Item(id: UUID(), title: "Lunch at Cafe", location: "Central Park", time: Date(), description: "Enjoy local cuisine.", type: .food)
        ])
        
        DeleteActivityView(dayPlan: .constant(dayPlan))
            .environmentObject(TripViewModel())
    }
}

