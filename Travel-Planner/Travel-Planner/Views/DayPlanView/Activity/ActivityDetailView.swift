//
//  AddTripItemView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/8/24.
//
import SwiftUI

struct ActivityDetailView: View {
    
    @ObservedObject var activity: ActivityEntity
    @StateObject var vm: ActivityViewModel
    @State var isShowingEditItem: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            // Title and Location
            Text(activity.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            if let date = activity.time {
                VStack(alignment: .leading) {
                    Text(DateUtils.formattedDate_WeekDay_Date_Year(date))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text(date, style: .time)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            
            
            Divider()
            
            // Item Type
            HStack {
                Text("Type:")
                    .fontWeight(.semibold)
                Text(activity.type.displayName)
            }
            
            // Location
            if let location = activity.location {
                HStack {
                    Text("Location:")
                        .fontWeight(.semibold)
                    Text(location)
                }
            }
            
            // Notes
            if let notes = activity.notes {
                VStack(alignment: .leading) {
                    Text("Notes:")
                        .fontWeight(.semibold)
                    Text(notes)
                        .padding(.top, 4)
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    vm.deleteActivity(activity)
                    dismiss()
                } label: {
                    Text("Delete Activity")
                        .fontWeight(.semibold)
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding(.bottom, 20)
            
        }
        .padding()
        .navigationTitle("Activity Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingEditItem) {
            NavigationStack {
                EditActivityView(activity: activity, vm: vm)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    isShowingEditItem.toggle()
                }
                .fontWeight(.bold)
                .foregroundStyle(.red)
            }
        }
    }
}
