//
//  ActivityDetail.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/29/24.
//
import SwiftUI

struct ActivityDetailView: View {
    
    var item: Item
    
    //    var title: String
    //    var location: String
    //    var itemType: ItemType
    //    var date: Date
    //    var url: String
    //    var notes: String
    //    var images: [String] // Array of images to display
    //    var review: String // Review text display
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            // Title and Location
            Text(item.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            if let date = item.date {
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
                Text(ItemTypeUtils.itemTypeDisplayName(for: item.type))
            }
            
            // Location
            if let location = item.location {
                HStack {
                    Text("Location:")
                        .fontWeight(.semibold)
                    Text(location)
                }
            }
            
            // URL
            if let url = item.url {
                HStack {
                    Text("URL:")
                        .fontWeight(.semibold)
                    Text(url)
                        .foregroundColor(.blue)
                        .underline()
                }
            }
            
            // Notes
            if let notes = item.notes {
                VStack(alignment: .leading) {
                    Text("Notes:")
                        .fontWeight(.semibold)
                    Text(notes)
                        .padding(.top, 4)
                }
            }
            
            // Images
            if let images = item.images {
                VStack(alignment: .leading) {
                    Text("Images:")
                        .fontWeight(.semibold)
                    ScrollView(.horizontal) {
                        HStack(spacing: 10) {
                            ForEach(images, id: \.self) { image in
                                Image(image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }
                }
                .padding(.top, 10)
            }
            
            // Review
            if let review = item.review {
                VStack(alignment: .leading) {
                    Text("Review:")
                        .fontWeight(.semibold)
                    Text(review)
                        .padding(.top, 4)
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    
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
    }
}
