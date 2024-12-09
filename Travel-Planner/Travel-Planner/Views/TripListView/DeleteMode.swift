//
//  DeleteMode.swift
//  Travel-Planner
//
//  Created by siye yang on 12/5/24.
//

import SwiftUI

struct DeleteMode: View {
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

