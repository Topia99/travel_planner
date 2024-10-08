//
//  ActivityCell.swift
//  Travel-Planner
//
//  Created by Jason Zeng on 10/2/24.
//

import SwiftUI

struct ActivityCellView: View {
    
    let iconName: String
    let iconColor: Color
    let title: String
    let time: String
    let description: String
    
    var body: some View {
        VStack (alignment: .leading){
            HStack() {
                
                // Activity Symbol
                Image(systemName: iconName)
                    .resizable()
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.white, iconColor)
                    .scaledToFit()
                    .frame(width: 30)
                
                // Activity Title
                Text(title)
                    .font(.headline)
                    .padding(.leading, 3)
                
                Spacer()
    
                Text(time)
                    .font(.headline)
            }
            
            Text(description)
        }
        .padding(.leading)
        .padding(.top, 25)
    }
}

#Preview {
    ActivityCellView(iconName: "car.circle.fill", iconColor: .orange, title: "Heading to Lake Tahoe", time: "10:00", description: "Leaving from Jason's house at 10:00. Jason, Sam, and Rainnie in one car, and Jerry, xiaoyu, and Hunter in one car. Gather at Xiaoyu's house at about 11:00.")
}
