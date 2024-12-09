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
    @State private var isShowingEditItem: Bool = false

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Before you create the TabView
                if let imageNames = activity.imageNames, !imageNames.isEmpty {
                    TabView {
                        ForEach(imageNames, id: \.self) { name in
                            if let image = ImageFileManager.instance.getImage(name: name) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .frame(width: UIScreen.main.bounds.width, height: 500)
                                    .clipped()
                            } else {
                                // If the image can't be loaded, you can show a placeholder:
                                Rectangle()
                                    .foregroundColor(.gray.opacity(0.3))
                                    .frame(width: UIScreen.main.bounds.width, height: 500)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(width: UIScreen.main.bounds.width, height: 500)
                    .edgesIgnoringSafeArea(.all)}


                // Date and Time
                if let date = activity.time {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(DateUtils.formattedDate_WeekDay_Date_Year(date))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(date, style: .time)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }

                // Item Type
                HStack {
                    Text("Type:")
                        .fontWeight(.semibold)
                    Text(activity.type.displayName)
                }

                // Location
                if let location = activity.location, !location.isEmpty {
                    HStack {
                        Text("Location:")
                            .fontWeight(.semibold)
                        Text(location)
                    }
                }

                // Notes
                if let notes = activity.notes, !notes.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Notes:")
                            .fontWeight(.semibold)
                        Text(notes)
                            .padding(.top, 4)
                    }
                }

                // Delete Activity Button
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
                .padding(.vertical, 20)
            }
            .padding()
        }
        .navigationTitle(activity.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    isShowingEditItem.toggle()
                }
                .fontWeight(.bold)
                .foregroundStyle(Color.middleGreen)
            }
        }
        .sheet(isPresented: $isShowingEditItem) {
            NavigationStack {
                EditActivityView(activity: activity, vm: vm)
            }
        }
    }
}
