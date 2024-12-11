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
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Display images in a paged TabView with unique IDs for each image
                if let imageDataArray = activity.images, !imageDataArray.isEmpty {
                    TabView {
                        ForEach(Array(imageDataArray.enumerated()), id: \.offset) { index, data in
                            if let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                    .frame(width: UIScreen.main.bounds.width, height: 500)
                                    .clipped()
                            } else {
                                Rectangle()
                                    .foregroundColor(.gray.opacity(0.3))
                                    .frame(width: UIScreen.main.bounds.width, height: 500)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                            }
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .frame(width: UIScreen.main.bounds.width, height: 500)
                    .edgesIgnoringSafeArea(.all)
                }
                
                if let date = activity.time {
                    VStack(alignment: .leading) {
                        Text(DateUtils.formattedDate_WeekDay_Date_Year(date))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(date, style: .time)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 16)
                }
                
                Divider()
                
                // Item Type
                HStack {
                    Text("Type:")
                        .fontWeight(.semibold)
                    Text(activity.type.displayName)
                }
                .padding(.horizontal, 16)
                
                // Location
                if let location = activity.location {
                    HStack {
                        Text("Location:")
                            .fontWeight(.semibold)
                        Text(location)
                    }
                    .padding(.horizontal, 16)
                }
                
                // Notes
                if let notes = activity.notes {
                    VStack(alignment: .leading) {
                        Text("Notes:")
                            .fontWeight(.semibold)
                        Text(notes)
                            .padding(.top, 4)
                    }
                    .padding(.horizontal, 16)
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
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .navigationTitle(activity.title)
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
