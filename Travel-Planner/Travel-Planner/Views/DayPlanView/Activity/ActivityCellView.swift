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
        VStack (alignment: .leading){
            HStack() {
                
                ItemIconView(imageName: activity.type.iconName,
                             color: activity.type.iconColor)
                
                // Activity Title
                Text(activity.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.leading, 3)
                
                Spacer()
                
                if let time = activity.time {
                    Text(time, style: .time)
                        .font(.headline)
                }
            }
            
            
            VStack (alignment: .leading) {
                if let location = activity.location{
                    Text("📍\(location)")
                        .font(.subheadline)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                if let notes = activity.notes {
                    Text(notes)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 2)
                }
            }
        }
        .padding()
        .frame(width: 350)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .opacity(0.5)
                .shadow(radius: 2)
        )
    }
}

struct ItemIconView: View {
    
    let imageName: String
    let color: Color
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .symbolRenderingMode(.palette)
            .foregroundStyle(.white, color)
            .frame(width: 30, height: 30)
    }
}
