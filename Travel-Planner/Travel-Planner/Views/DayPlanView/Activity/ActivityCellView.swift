//
//  ItemFoodCellView.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/2/24.
//

import SwiftUI

struct ActivityCellView: View {
    
    @ObservedObject var activity: ActivityEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 20) {
                // Icon View
                ItemIconView(imageName: activity.type.iconName, color: .gray)
                
                VStack (alignment: .leading, spacing: 10) {
                    HStack {
                        // Title (Single Line)
                        Text(activity.title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                            .truncationMode(.tail)
                        
                        Spacer()
                        
                        // Time (12-Hour Format with AM/PM)
                        if let time = activity.time {
                            Text(DateUtils.twelveHoursClockTime(time))
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    // Notes (Single Line, Lighter Gray)
                    if let notes = activity.notes {
                        Text(notes)
                            .font(.body)
                            .foregroundColor(Color.gray.opacity(0.85))
                            .lineLimit(1)
                            .truncationMode(.tail)
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(white: 1, opacity: 1))
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 1)
            
        )
    }
}

struct ItemIconView: View {
    let imageName: String
    let color: Color
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 25, height: 25)
            .foregroundColor(color)
    }
}
